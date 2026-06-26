# Piloto: como usar (Renan + Lírios)

15 textos. Cada um de vocês dá nota sozinho, sem ver a do outro. Não precisa saber nada de gramática.

## Passo a passo

1. **Você:** abre `anotador.html` no navegador (duplo-clique, funciona offline). Escreve seu nome, responde as 3 perguntas de cada texto (Não / Um pouco / Sim), clica **Salvar minha resposta**. Baixa um arquivo `resposta-<seunome>.csv`.
2. **Manda o `anotador.html` pro seu amigo** (WhatsApp, e-mail). Ele abre no navegador dele, faz igual, te devolve o arquivo dele.
3. **Cada um sozinho.** Sem combinar nota, sem ver a do outro antes de salvar. É isso que faz o teste valer.
4. **Junta:** na mesma página, lá embaixo em "Vocês deram as mesmas notas?", carrega os 2 arquivos. Sai na hora em quantos textos vocês bateram, por pergunta.

## O que o resultado quer dizer

- **Bateram quase sempre / bem:** a pergunta tá clara, pode confiar.
- **Divergiram muito numa pergunta:** não é culpa de vocês. Quer dizer que aquela pergunta (ou os exemplos dela) tá mal explicada. A gente arruma o texto da pergunta e vocês refazem.
- Só depois de salvar e comparar é que vale conversar sobre as diferenças.

## O que tem nessa pasta

- `anotador.html` — a tela onde vocês pontuam (é só esse arquivo, manda ele pro amigo).
- `trechos-mestre.csv` — de onde veio cada texto (não abre antes de pontuar, ia influenciar).
- `kappa.py` (na pasta `scripts/`) — o mesmo cálculo da tela, pra quem quiser rodar no terminal.

## Por que isso importa

Esses 15 são o teste do teste: servem pra ver se as 3 perguntas estão claras o bastante pra duas pessoas darem notas parecidas. Se passar, a gente parte pros 100-150 textos de verdade. Se duas pessoas não concordam, a régua ainda não tá pronta, e é melhor descobrir agora.
