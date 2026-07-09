# Casos reais: antes e depois

Dez trechos que passaram pelo gororoba de verdade. Nada aqui é forjado pra parecer bonito
no papel: os dez "antes" saem do `dataset/anotacao.csv`, o dataset anotado deste projeto,
com a coluna `fonte` citada em cada caso. Nove vêm da classe `ia-sem-voz` (texto gerado com
prompt raso, sem direção de voz), um vem de fala espontânea real (`humano-com-voz`,
transcrição do NURC/Recife), incluído de propósito pra mostrar que a régua também acende
fora do alvo principal.

Os "depois" não são depoimento de usuário. São a reescrita temperada, na voz da casa, que
carrega o mesmo recado do "antes" e passa limpo na régua. Cada bloco foi validado
individualmente com `vale --ext=.md`, saída zero alertas.

## 1. Gestão de equipes

Fonte: `gerado: prompt raso, tema gestão` (dataset id 001, classe `ia-sem-voz`)

```text
No mundo de hoje, a gestão de equipes desempenha um papel fundamental no sucesso das organizações, e vale ressaltar que líderes preparados fazem toda a diferença.
```

Sinais:
- `Gororoba.Aberturas`: `No mundo de hoje`
- `Gororoba.Conectivos`: `vale ressaltar que`

```text
Equipe boa não sobrevive sem liderança boa. Time preparado é o que separa organização
que entrega de organização que só promete.
```

Nota: cortou a abertura de garganta limpa e o conectivo de tradução, foi direto no
recado.

## 2. Saúde mental

Fonte: `gerado: prompt raso, tema saúde` (dataset id 002, classe `ia-sem-voz`)

```text
É importante destacar que a saúde mental vem ganhando cada vez mais espaço nas discussões contemporâneas, e nota-se que o autocuidado se tornou indispensável.
```

Sinais:
- `Gororoba.Conectivos`: `É importante destacar que`
- `Gororoba.VozPassiva`: `nota-se que`

```text
Saúde mental parou de ser tabu. Cuidar de si virou tão essencial quanto comer direito.
```

Nota: trocou o conectivo de tradução e a fórmula impessoal por sujeito ativo, e a
metáfora de comida deu corpo à ideia.

## 3. Transformação digital

Fonte: `gerado: prompt raso, tema tecnologia` (dataset id 004, classe `ia-sem-voz`)

```text
No cenário atual, a tecnologia evolui de forma acelerada, e dessa forma constata-se que a transformação digital impacta todos os setores da sociedade.
```

Sinais:
- `Gororoba.VozPassiva`: `constata-se que`

```text
A tecnologia anda rápido demais. Nenhum setor fica de fora da transformação digital.
```

Nota: só a passiva burocrática acendeu aqui. Tirou o sujeito escondido, frase ficou
mais curta e mais forte.

## 4. Sustentabilidade

Fonte: `gerado: prompt raso, tema sustentabilidade` (dataset id 005, classe
`ia-sem-voz`)

```text
Vale ressaltar que a sustentabilidade deixou de ser uma opção para se tornar uma necessidade, e nesse sentido as empresas precisam repensar suas práticas.
```

Sinais:
- `Gororoba.Conectivos`: `Vale ressaltar que`
- `Gororoba.Conectivos`: `nesse sentido`

```text
Sustentabilidade deixou de ser opção. Virou necessidade, e as empresas precisam
repensar as próprias práticas.
```

Nota: o mesmo conectivo de tradução repetia duas vezes na mesma frase. Quebrar em duas
frases curtas resolveu as duas ocorrências de uma vez.

## 5. Produtividade

Fonte: `gerado: prompt raso, tema produtividade` (dataset id 008, classe `ia-sem-voz`)

```text
Nesse sentido, a produtividade tornou-se um tema central no ambiente corporativo, e foi observado que a organização do tempo melhora os resultados de forma significativa.
```

Sinais:
- `Gororoba.Conectivos`: `Nesse sentido`
- `Gororoba.VozPassiva`: `foi observado`

```text
Produtividade virou tema central nas empresas. Organizar o tempo melhora o resultado,
e isso a gente já sabe.
```

Nota: conectivo de abertura e passiva de relatório saíram juntos, o "a gente já sabe"
resolve como voz ativa e direta.

## 6. Relacionamentos

Fonte: `gerado: prompt raso, tema relacionamentos` (dataset id 009, classe
`ia-sem-voz`)

```text
Os relacionamentos interpessoais desempenham um papel fundamental na qualidade de vida, e diante disso constata-se que a comunicação é a base de toda conexão.
```

Sinais:
- `Gororoba.VozPassiva`: `constata-se que`

```text
Relação boa sustenta qualidade de vida. Toda conexão que funciona tem a mesma base:
comunicação.
```

Nota: um alerta só, mas a frase inteira também estava inchada de jargão vago. A
reescrita cortou o excesso além do que a régua pegou.

## 7. Nutrição

Fonte: `gerado: prompt raso, tema nutrição` (dataset id 015, classe `ia-sem-voz`)

```text
É importante destacar que a alimentação saudável impacta diretamente a longevidade, e nesse sentido nota-se que escolhas conscientes fazem toda a diferença.
```

Sinais:
- `Gororoba.Conectivos`: `É importante destacar que`
- `Gororoba.Conectivos`: `nesse sentido`
- `Gororoba.VozPassiva`: `nota-se que`

```text
Comer bem estica a vida. Escolha consciente no prato faz diferença lá na frente.
```

Nota: o trecho com mais sinais dos dez casos, três alertas numa frase só. Tema de
nutrição pediu a metáfora de comida direto, sem forçar.

## 8. Trabalho remoto

Fonte: `gerado: prompt raso, tema trabalho remoto` (dataset id 018, classe
`ia-sem-voz`)

```text
No mundo de hoje, o trabalho remoto consolidou-se como uma realidade, e em suma constata-se que a flexibilidade aumenta a satisfação dos colaboradores.
```

Sinais:
- `Gororoba.Aberturas`: `No mundo de hoje`
- `Gororoba.VozPassiva`: `constata-se que`

```text
Trabalho remoto virou realidade. Flexibilidade deixa o time mais satisfeito, e isso
pesa no resultado.
```

Nota: abertura de garganta limpa e passiva de relatório saíram, o "e isso pesa no
resultado" fecha com consequência concreta em vez de conclusão genérica.

## 9. Consumo consciente

Fonte: `gerado: prompt raso, tema consumo consciente` (dataset id 019, classe
`ia-sem-voz`)

```text
Sendo assim, o consumo consciente ganha cada vez mais força no cenário atual, e é importante destacar que cada escolha individual reflete no coletivo.
```

Sinais:
- `Gororoba.Conectivos`: `é importante destacar que`

```text
Consumo consciente ganha força. Cada escolha individual pesa no coletivo.
```

Nota: um sinal só, mas mostra o padrão mínimo: corta o conectivo de abertura, o resto
da frase já estava de pé sozinho.

## 10. Fala espontânea (fora do alvo principal)

Fonte: `NURC/RE Inq.340 D2 p.68 (fale.ufal.br/projeto/nurcdigital)` (dataset id 060,
classe `humano-com-voz`, corpus de fala real, não gerado por IA)

```text
Acho que o Brasil é Brasil e a gente tem que cantar é brasileiro, não é nem português, é em brasileiro.
```

Sinais:
- `Gororoba.ParalelismoNegativo`: `não é nem português, é `

```text
Acho que o Brasil é Brasil: a gente canta em brasileiro, no nosso jeito, longe do
português de Portugal.
```

Nota: este é o único caso dos dez que não é IA sem voz. É fala espontânea legítima,
e o molde "não é X, é Y" acendeu nela do mesmo jeito. `docs/falsos-positivos.md`
já assume esse risco de propósito: o eixo é `suggestion`, o nível mais baixo da
régua, porque contraste retórico de verdade existe e não pode travar texto. Caso
incluído aqui pra não esconder o ponto fraco.

## Fontes e validação

Os dez "antes" estão em `dataset/anotacao.csv` nos ids 001, 002, 004, 005, 008, 009,
015, 018, 019 e 060, com a coluna `fonte` original preservada em cada caso acima. Os
dez "depois" passam em `vale --ext=.md` com zero alertas, um a um e no arquivo
inteiro.

Sugestão de trecho pro README, na seção de exemplos:

```text
Dez casos reais de antes e depois, tirados do dataset anotado do projeto, estão em
[docs/casos.md](docs/casos.md).
```
