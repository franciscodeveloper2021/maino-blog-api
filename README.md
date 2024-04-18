# Desafio API de Blog - Maino

Este repositório tem como objetivo apresentar a solução desenvolvida para o desafio proposto pela empresa Maino, que consiste na criação de uma API para um blog.

## Requisitos do Desafio

### Área Deslogada

Na área deslogada, os usuários devem poder:

- Ver os posts publicados por todos os usuários, ordenados do mais novo para o mais antigo.
- Os posts publicados devem ter paginação ao atingirem 3 publicações, onde o 4º post irá para a página 2 e daí em diante. Cada página deverá conter até 3 posts.
- Fazer comentários anônimos nos posts.
- Cadastrar um novo usuário.
- Fazer login com um usuário cadastrado.
- Recuperar a senha do usuário.

### Área Logada

Na área logada, os usuários autenticados devem poder:

- Redigir e publicar um post.
- Editar e apagar posts já publicados pelo próprio usuário logado.
- Fazer comentários identificados através do login.
- Editar o seu cadastro de usuário.
- Alterar a senha do usuário logado.

## Tecnologias Utilizadas

- Linguagem de programação: Ruby.
- Framework de desenvolvimento: Ruby on Rails.
- Banco de dados: Postgresql.
- Ferramentas de autenticação e segurança: JWT, bcrypt.


