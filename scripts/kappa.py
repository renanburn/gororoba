#!/usr/bin/env python3
"""
kappa.py — kappa de Cohen por eixo entre dois anotadores do gororoba.

Lê duas cópias do anotacao.csv (uma por anotador), casa as linhas por `id`, e
calcula o kappa de Cohen para cada eixo de score (conectivo, voz-passiva, clichê).

Usa sklearn.metrics.cohen_kappa_score se disponível; senão cai num cálculo próprio
(mesma fórmula, sem dependência). Não baixa nada, não precisa de dados reais.

Uso:
    python3 scripts/kappa.py anotacao-a.csv anotacao-b.csv
    python3 scripts/kappa.py --self-test

A escala dos scores é 0/1/2 (ver docs/guia-anotacao.md). O kappa é tratado como
nominal (categorias 0,1,2): é a leitura conservadora e a que vai pro README.
"""

import csv
import sys

EIXOS = ["conectivo_score", "vozpassiva_score", "cliche_score"]


def cohen_kappa_manual(a, b):
    """Kappa de Cohen nominal, sem dependência. a e b são listas pareadas."""
    n = len(a)
    if n == 0:
        raise ValueError("sem pares para comparar")
    labels = sorted(set(a) | set(b))
    # concordância observada
    po = sum(1 for x, y in zip(a, b) if x == y) / n
    # concordância esperada por acaso
    pe = 0.0
    for lab in labels:
        pa = sum(1 for x in a if x == lab) / n
        pb = sum(1 for y in b if y == lab) / n
        pe += pa * pb
    if pe == 1.0:
        # concordância total e sem variância: kappa é 1.0 por convenção
        return 1.0
    return (po - pe) / (1 - pe)


def cohen_kappa(a, b):
    try:
        from sklearn.metrics import cohen_kappa_score
        return float(cohen_kappa_score(a, b))
    except ImportError:
        return cohen_kappa_manual(a, b)


def carrega(caminho):
    """Lê um CSV de anotação. Retorna {id: {eixo: int}}."""
    linhas = {}
    with open(caminho, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        faltando = [c for c in (["id"] + EIXOS) if c not in (reader.fieldnames or [])]
        if faltando:
            raise ValueError(f"{caminho}: colunas faltando: {faltando}")
        for row in reader:
            rid = (row.get("id") or "").strip()
            if not rid:
                continue
            scores = {}
            for eixo in EIXOS:
                val = (row.get(eixo) or "").strip()
                if val == "":
                    scores[eixo] = None
                else:
                    scores[eixo] = int(val)
            linhas[rid] = scores
    return linhas


def calcula(caminho_a, caminho_b):
    a = carrega(caminho_a)
    b = carrega(caminho_b)
    ids = sorted(set(a) & set(b))
    if not ids:
        raise ValueError("nenhum id em comum entre os dois arquivos")

    so_a = sorted(set(a) - set(b))
    so_b = sorted(set(b) - set(a))

    print(f"Anotador A: {caminho_a} ({len(a)} linhas)")
    print(f"Anotador B: {caminho_b} ({len(b)} linhas)")
    print(f"Pareados por id: {len(ids)}")
    if so_a:
        print(f"  Só em A: {', '.join(so_a)}")
    if so_b:
        print(f"  Só em B: {', '.join(so_b)}")
    print()

    resultados = {}
    for eixo in EIXOS:
        va, vb = [], []
        for rid in ids:
            sa, sb = a[rid][eixo], b[rid][eixo]
            if sa is None or sb is None:
                continue
            va.append(sa)
            vb.append(sb)
        if not va:
            print(f"  {eixo:18s}: sem pares completos (não anotado)")
            resultados[eixo] = None
            continue
        k = cohen_kappa(va, vb)
        resultados[eixo] = k
        print(f"  {eixo:18s}: kappa = {k:.3f}  (n={len(va)})")
    return resultados


def self_test():
    """Prova que roda, com dados sintéticos pequenos (NÃO são dataset real)."""
    import os
    import tempfile

    # Dois anotadores fictícios: concordam em quase tudo, divergem de propósito
    # numa linha por eixo, pra o kappa não sair 1.000 trivial.
    header = ("id,trecho,fonte,classe_origem,conectivo_score,vozpassiva_score,"
              "cliche_score,anotador,notas\n")
    a = header + (
        's1,sintetico,test,ia-sem-voz,2,1,2,A,\n'
        's2,sintetico,test,humano-com-voz,0,0,0,A,\n'
        's3,sintetico,test,seo-generico,1,2,1,A,\n'
        's4,sintetico,test,humano-simples-regional,0,1,0,A,\n'
    )
    b = header + (
        's1,sintetico,test,ia-sem-voz,2,1,2,B,\n'
        's2,sintetico,test,humano-com-voz,0,0,1,B,\n'   # diverge no clichê
        's3,sintetico,test,seo-generico,1,2,1,B,\n'
        's4,sintetico,test,humano-simples-regional,0,1,0,B,\n'
    )

    d = tempfile.mkdtemp(prefix="kappa-selftest-")
    pa, pb = os.path.join(d, "a.csv"), os.path.join(d, "b.csv")
    with open(pa, "w", encoding="utf-8") as f:
        f.write(a)
    with open(pb, "w", encoding="utf-8") as f:
        f.write(b)

    print("== AUTO-TESTE (dados sintéticos, não é o dataset) ==\n")
    res = calcula(pa, pb)

    # Checagens: o cálculo manual e o sklearn (se houver) têm que bater num caso
    # conhecido; e o eixo com divergência tem que cair abaixo dos que casam 100%.
    perfeito = cohen_kappa_manual([0, 1, 2, 0], [0, 1, 2, 0])
    assert abs(perfeito - 1.0) < 1e-9, f"concordância total devia dar 1.0, deu {perfeito}"

    parcial = cohen_kappa_manual([0, 0, 0, 0], [0, 0, 1, 0])
    assert parcial < 1.0, "uma divergência devia baixar o kappa de 1.0"

    assert res["conectivo_score"] is not None and res["cliche_score"] is not None
    assert res["conectivo_score"] >= res["cliche_score"], (
        "o eixo que casa 100% (conectivo) devia ter kappa >= ao eixo com "
        "divergência (clichê)"
    )

    print("\nOK: kappa.py passou no auto-teste.")
    return 0


def main(argv):
    if len(argv) == 2 and argv[1] in ("--self-test", "--selftest", "-t"):
        return self_test()
    if len(argv) != 3:
        print(__doc__.strip())
        print("\nErro: passe dois CSVs, ou --self-test.", file=sys.stderr)
        return 2
    calcula(argv[1], argv[2])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
