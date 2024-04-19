# Desafio API de Blog - Maino

Este repositório tem como objetivo apresentar a solução desenvolvida para o desafio proposto pela empresa Maino, que consiste na criação de uma API para um blog.

### Avisos

- Devido a priorização de outras funcionalidades para a otimização de tempo, 1 funcionalidade ficou de fora, a **Recuperação de Senha**
- Apenas a API sem as views foi possível de ser deployada. Porém vocÊ pode visualizar os posts no browser pela rota `https://mysite-hojm.onrender.com`
- Os testes devem ser realizados por meio de um cliente como **Postman** ou **Insomnia**.

## Requisitos do Desafio

### Área Deslogada

- Ver os posts publicados por todos os usuários, ordenados do mais novo para o mais antigo.
- Paginação dos posts: a cada 3 publicações, o 4º post vai para a próxima página. Cada página contém até 3 posts.
- Cadastro de novo usuário.
- Login de usuário cadastrado.

### Área Logada

- Redigir e publicar um post.
- Editar e apagar posts já publicados pelo próprio usuário logado.
- Editar o cadastro do usuário.

## Tecnologias Utilizadas

- Linguagem de programação: Ruby.
- Framework de desenvolvimento: Ruby on Rails.
- Banco de dados: PostgreSQL.
- Ferramentas de autenticação e segurança: JWT, bcrypt.

## Como testar

### Ver os posts publicados por todos os usuários

- Acesse a rota: `https://mysite-hojm.onrender.com/posts` **GET**

### Trocar de página para ver outros posts mais antigos

- Acesse a rota: `https://mysite-hojm.onrender.com/posts?page=2` **GET**

- Troque o valor da variável page pelo número da página que você deseja acessar, caso a página não tenha nenhum contéudo, um array vazio irá retornar.

### Fazer comentários

- Acesse a rota: `https://mysite-hojm.onrender.com/comments` **POST**

- Coloque os parametros do comentário, por exemplo:
```
{
  "comment": {
    "body": "Este é um novo comentário.",
    "post_id": (id do post),
    "user_id": (seu id)
  }
}
```

### Cadastrar novo usuário

- Acesse a rota: `https://mysite-hojm.onrender.com/users` **POST**

- Coloque os parametros do usuário, por exemplo:
```
{
    "user": {
        "name": "Tiago",
        "last_name": "Maionese",
        "email": "tiaguinho@maionese.com",
        "password": "123456",
        "password_confirmation": "123456"
    }
}
```
- **Importante** Há validações para o tamnho de cada atributo, assim como também regex para o email. É importante verificar na code base as regras de negócio dos usuários quando fizer o teste. Elas se econtram no **Model** User. Porém erros personalizados retornarão indicando o erro do parâmetro específico.

### Login de usuário cadastrado

 - Acesse a rota: `https://mysite-hojm.onrender.com/login` **POST**

- Coloque os parâmetros para a autenticação:
```
{
  "email": "tiaguinho@maionese.com",
  "password": "123456"
}
```
- Você receberá um token JWT como repsosta, exemplo: 

```token eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.mEJWMrdc0KptbXLg1xVjzrKo37J8uLS2-55t7ZHfgK8 ```

- Você deve colocar esse token nos seus **Headers** com a key: **Authorization** e o value: **Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.mEJWMrdc0KptbXLg1xVjzrKo37J8uLS2-55t7ZHfgK8**

 - Após isso siga para próxima etapa

### Redigir e publicar um post

 Acesse a rota: `https://mysite-hojm.onrender.com/posts` **POST**

- Coloque os parametros do post, por exemplo:
```
{
  "post": {
     "title": "Titulo do Tiago",
     "body": "Body do Tiago",
     "user_id": (seu id)
   }
}

```
- **Importante** O usuário precisa ter feito o login para criar o post

### Editar um post

Acesse a rota: `https://mysite-hojm.onrender.com/posts/:id` **PUT**

- Coloque os parametros do post, por exemplo:
```
{
  "post": {
     "title": "Titulo do Tiago atualizado",
     "body": "Body do Tiago atualizado",
   }
}

```

- **Importante** Você só poderá editar o post se for o seu usuário que tiver criado

### Excluir um post

Acesse a rota: `https://mysite-hojm.onrender.com/posts/:id` **DELETE**

- **Importante** Você só poderá excluir o post se for o seu usuário que tiver criado

### Editar o cadastro do usuário

Acesse a rota: `https://mysite-hojm.onrender.com/users/:id`

- Coloque os parametros do usuário, por exemplo:

```
{
    "user": {
        "password": "atualizado",
        "password_confirmation": "atualizado"
    }
}
```

- **Importante** Você só poderá editar o seu usuário e se tiver logado
