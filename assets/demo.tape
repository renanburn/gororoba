# Gera assets/demo.gif. Reproduzir: vhs assets/demo.tape (precisa de vale + vhs no PATH)
Output assets/demo.gif

Set Shell "bash"
Set FontSize 22
Set Width 1100
Set Height 700
Set Padding 30
Set Theme "Catppuccin Mocha"
Set TypingSpeed 50ms

Hide
Type "export PATH=/opt/homebrew/bin:$PATH; cd assets; clear" Enter
Show
Sleep 700ms

Type "# o mesmo recado, requentado:" Enter
Sleep 500ms
Type "cat requentado.md" Enter
Sleep 1.8s
Type "vale requentado.md" Enter
Sleep 3s

Type "# agora, temperado:" Enter
Sleep 500ms
Type "cat temperado.md" Enter
Sleep 1.6s
Type "vale temperado.md" Enter
Sleep 3s
