Jogo Medieval Godot - README.md
Tiny Medieval Crazies

Índice
Sobre
Instalação
Como Jogar
Configurações
Contribuição
Licença
Contato
Sobre
"Tiny Medieval Crazies" é um jogo de ação e aventura desenvolvido com Godot Engine, ambientado em um mundo medieval. O jogador assume o papel de um herói destemido, enfrentando desafios, inimigos e explorando masmorras para salvar o reino de uma ameaça sombria.


------------------------------------------------------------------------------------


Instalação
Para clonar e executar o projeto localmente, siga os passos abaixo:

Clone o repositório:

sh
Copiar código
git clone https://github.com/SeuUsuario/Desafio_Godot.git
Navegue até o diretório do projeto:

sh
Copiar código
cd Desafio_Godot
Abra o projeto no Godot:

Abra o Godot Engine.
Clique em "Importar".
Navegue até o diretório do projeto e selecione o arquivo project.godot.
Clique em "Importar & Editar".
Como Jogar
Movimentação: Use as teclas W, A, S, D para mover o personagem.
Ataque: Pressione Espaço ou clique com o botão esquerdo do mouse para atacar.
Interação: Use a tecla E para interagir com objetos e personagens no jogo.
Inventário: Pressione I para abrir o inventário.
Menu: Pressione Esc para acessar o menu do jogo.


Configurações
Engine Configuration


; Arquivo de configuração da engine.
; É melhor editá-lo usando a interface do editor e não diretamente,
; pois os parâmetros que vão aqui não são todos óbvios.

config_version=5

[application]
config/name="Tiny Medieval Crazies"
run/main_scene="res://test_scenes/main.tscn"
config/features=PackedStringArray("4.2", "Forward Plus")
config/icon="res://icon.svg"

[autoload]
GameManager="*res://game_manager.gd"

[display]
window/stretch/mode="canvas_items"

[input]
move_up={
"deadzone": 0.5,
"events": [Object(InputEventKey, "physical_keycode":87), Object(InputEventKey, "physical_keycode":4194320)]
}
move_down={
"deadzone": 0.5,
"events": [Object(InputEventKey, "physical_keycode":83), Object(InputEventKey, "physical_keycode":4194322)]
}
move_left={
"deadzone": 0.5,
"events": [Object(InputEventKey, "physical_keycode":65), Object(InputEventKey, "physical_keycode":4194319)]
}
move_right={
"deadzone": 0.5,
"events": [Object(InputEventKey, "physical_keycode":68), Object(InputEventKey, "physical_keycode":4194321)]
}
attack={
"deadzone": 0.5,
"events": [Object(InputEventMouseButton, "button_index":1), Object(InputEventKey, "physical_keycode":32)]
}

[rendering]
textures/canvas_textures/default_texture_filter=0

----------------------------------------------------------------------------------


Contribuição
Contribuições são bem-vindas! Se você deseja contribuir com o projeto, siga os passos abaixo:

Faça um fork do projeto.
Crie uma nova branch: git checkout -b minha-nova-feature
Faça suas alterações e confirme-as: git commit -m 'Adiciona uma nova feature'
Envie para o branch original: git push origin minha-nova-feature
Crie um pull request.
Por favor, verifique se há problemas abertos antes de começar a trabalhar em uma nova feature.

Licença
Este projeto está licenciado sob a Licença MIT - veja o arquivo LICENSE para mais detalhes.

-----------------------------------------------------------------------------------

Contato
Autor: Winicius F. Pichirilo
Email: winy162010@hotmail.com
GitHub: WiniciusPichirilo
LinkedIn: https://www.linkedin.com/in/winicius-f-pichirilo-1aab231a2/

-------------------------------------------------------------------------------------

Feito com 💖 usando Godot Engine

