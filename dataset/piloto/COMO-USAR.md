# Piloto de anotação: como operar (Renan + 1 amigo)

15 trechos, anotação **cega** e **independente**. O piloto não é o benchmark final: serve pra calibrar o guia e os dois anotadores antes do dataset de 100-150. O número honesto é o kappa de **antes** de vocês conversarem.

## Passo a passo

1. **Você (Renan):** abre `anotador.html` no navegador (duplo-clique, funciona offline, não precisa instalar nada). Põe seu nome em "QUEM É VOCÊ", pontua os 15 trechos (0/1/2 em cada eixo), clica **Exportar minha anotação**. Sai um `anotacao-renan.csv`.
2. **Manda o `anotador.html` pro seu amigo** (WhatsApp, e-mail, o que for). Ele faz o mesmo no navegador dele, exporta o `anotacao-<nome>.csv` e te devolve.
3. **Não comparem antes de exportar.** Cada um pontua sozinho, sem ver o do outro. É isso que torna o kappa honesto.
4. **Compara:** na própria `anotador.html`, lá embaixo em "Comparar duas anotações", carrega os 2 CSVs. O kappa por eixo sai na hora.
   - Ou pelo script: `python3 ../../scripts/kappa.py anotacao-renan.csv anotacao-amigo.csv`

## Como ler o resultado

- **Kappa por eixo** (não um número só). Escala: <0.4 fraco, 0.4-0.6 moderado, 0.6-0.8 bom, 0.8+ ótimo.
- **Eixo com kappa baixo = problema no guia, não nos anotadores.** Quer dizer que o tell daquele eixo está mal definido ou os exemplos são ruins. Ajusta o `docs/guia-anotacao.md` e roda outro piloto.
- Só depois de medir, abram os desacordos e conversem (diferença de 1 ponto fecha em consenso; de 2, marca como disputado).

## Depois do piloto

- Se os 3 eixos derem kappa decente (~0.6+), o guia está calibrado: parte pro dataset real (100-150 trechos) seguindo `docs/plano-coleta.md`, com amostragem cega dos corpora (Carolina/NILC/ASSIN + amostras de IA/SEO/tradução).
- A chave de origem dos trechos do piloto (humano/IA/etc) está em `trechos-mestre.csv`, pra depois cruzar e checar o anteparo anti-viés: os trechos `humano-com-voz` e `humano-simples-regional` (mineirês) **têm que** receber score baixo dos dois. Se a régua punir mineirês, o piloto pegou o viés antes de virar dataset.

## Honestidade do piloto

Os trechos de máquina (ia-sem-voz, SEO, tradução, ia-bem-promptada) foram gerados pra isso. Os de voz humana e mineirês saíram de fonte real citada (`papo-reto/exemplos.md`). Alguns você pode reconhecer: é calibração, não o benchmark. O dataset real precisa de amostragem cega de fonte que nenhum dos dois anotadores tenha escrito.
