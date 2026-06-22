# Gera assets/demo.gif. Reproduzir: vhs assets/demo.tape (precisa de vale + vhs no PATH)
Output assets/demo.gif

Set Shell "bash"
Set FontSize 20
Set Width 1080
Set Height 640
Set Padding 28
Set Theme "Catppuccin Mocha"
Set TypingSpeed 55ms

Hide
Type "export PATH=/opt/homebrew/bin:$PATH; clear" Enter
Show
Sleep 700ms

Type "cat assets/demo.md" Enter
Sleep 1.6s

Type "vale assets/demo.md" Enter
Sleep 3s

Type "# agora, fala brasileira de verdade:" Enter
Sleep 500ms
Type "vale tests/voz-limpa.md" Enter
Sleep 3s
