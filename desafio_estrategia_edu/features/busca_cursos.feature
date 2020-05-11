#language: pt

Funcionalidade: Validar busca e filtragem de cursos
Cenário: Busca de cursos por professor Ena Loiola
    Dado que estou na pagina inicial 
    E utilizo a busca "POR PROFESSOR"
    E busco por "Ena Loiola"
    Quando acesso um curso da listagem
    Então valido todos detalhes do curso 

Cenário: Busca de cursos por matéria quantidade de cursos disponiveis 
    Dado que estou na pagina inicial 
    E utilizo a busca "POR MATÉRIA"
    Quando busco por "Matemática"
    E visualizo a tela de detalhes
    Então valido a quantidade de cursos exibidas

Cenário: Busca de cursos por região - São Paulo
    Dado que estou na pagina inicial 
    E utilizo a busca "POR REGIÃO"
    Quando seleciono "São Paulo"
    Então visualizo a tela com todos concursos da região escolhida
