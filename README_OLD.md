---
**IMPORTANTE**: Esse projeto não tem relação alguma com a SPTrans. Não temos informações sobre a possibilidade ou legalidade de utilização a API em aplicações de terceiros. Entre em contato com a SPTrans antes de utilizar esses recursos.
---

# Olho Vivo SPTrans

O site [Olho Vivo da SPTrans](http://olhovivo.sptrans.com.br/) oferece informações sobre a localização dos ônibus em uma série de linhas da capital Paulista.

Esse projeto visa documentar a API web utilizada pelo site para que, se autorizado pela SPTrans, possa ser utilizada por outras aplicações.

# API

Todos os recursos retornam uma representação no formado JSON (`Content-Type: application/json; charset=utf-8`).

# Credenciais

Para utilizar a API será necessário realizar uma requisição para a URL http://olhovivo.sptrans.com.br/ e obter o valor do cookie com a chave `apiCredentials-v0`.
Em todas as requisições para os recursos da API será necessário utilizar esse cookie, caso contrário todas as requisições serão recusadas por falta de autorização (HTTP 401).

    curl --dump-header sptrans_cookies http://olhovivo.sptrans.com.br/

retornará o seguinte resultado de erro em caso de falta de autorização em qualquer um dos recursos da API:

    {
      "Message": "Authorization has been denied for this request."
    }

## Paradas

Listagem e busca das paradas de ônibus monitoradas pelo programa Olho Vivo. 

    http://olhovivo.sptrans.com.br/v0/Parada/Buscar[?termosBusca={termo}]

O valor do parâmetro `termosBusca` será comparado com os atributos `Endereco` e `Nome` do recurso, p.ex.:

    curl --cookie sptrans_cookies http://olhovivo.sptrans.com.br/v0/Parada/Buscar?termosBusca=paulista

retornará o seguinte resultado:

    [
      {
        "CodigoParada": 260015039,
        "Nome": "PAULISTA B/C",
        "Endereco": " AV PAULISTA/ AV REBOUCAS ",
        "Latitude": -23.555883,
        "Longitude": -46.66306
      },
      {
        "CodigoParada": 260016855,
        "Nome": "PAULISTA C/B",
        "Endereco": "AV PAULISTA/ R ANTONIO CARLOS",
        "Latitude": -23.555176,
        "Longitude": -46.66237
      }
    ]

Se o parâmetro `termosBusca` for omitido será retornada a lista completa de paradas.


## Linhas

Busca por linhas de ônibus.

    http://olhovivo.sptrans.com.br/v0/Linha/Buscar?termosBusca={termo}

Nesse recurso o parâmetro `termosBusca` é obrigatório e será comparado ao atributos `DenominacaoTPTS` e `DenominacaoTSTP`, que são os nomes exibidos no letreiro dos ônibus da linha em cada sentido.

Exemplo:

    curl --cookie sptrans_cookies http://olhovivo.sptrans.com.br/v0/Linha/Buscar?termosBusca=imirim

retornará o seguinte resultado:

    [
      {
        "CodigoLinha": 568,
        "Circular": false,
        "Letreiro": "967A",
        "Sentido": 1,
        "Tipo": 10,
        "DenominacaoTPTS": "PINHEIROS",
        "DenominacaoTSTP": "IMIRIM",
        "Informacoes": null
      },
      {
        "CodigoLinha": 33336,
        "Circular": false,
        "Letreiro": "967A",
        "Sentido": 2,
        "Tipo": 10,
        "DenominacaoTPTS": "PINHEIROS",
        "DenominacaoTSTP": "IMIRIM",
        "Informacoes": null
      }
    ]


## Previsão

Previsão de chegada dos próximos ônibus de cada uma das linhas que atendem essa parada.

    http://olhovivo.sptrans.com.br/v0/Previsao/Parada?codigoParada={codigo_parada}

O parâmetro `codigoParada`, como o nome sugere, deve receber o valor indicado no atributo `CodigoParada` do recurso Parada. Por exemplo, o código da parada do cruzamento da Av. Paulista com a Rebolças é `260015039`, para consultar a previsão dos próximos ônibus nessa parada:

    curl --cookie sptrans_cookies http://olhovivo.sptrans.com.br/v0/Previsao/Parada?codigoParada=260015039

O nome dos atributos na representação das previsões são bem menos intuitivos que os demais recursos, então segue a lista dos atributos e respectivos significados:

| atributo          | descrição
|-------------------|-------------------------------------------------------
| `hr`              | hora atual no servidor (HH:MM)
| `p`               | objeto Parada
| `p.cp`            | código da parada
| `p.px`            | longitude da parada
| `p.py`            | latitude da parada
| `p.np`            | nome da próxima parada
| `p.l`             | lista de linhas com previsão
| `p.l[n].c`        | código da linha
| `p.l[n].cl`       | código interno da linha
| `p.l[n].lt0`      | letreiro da linha, sentido 1
| `p.l[n].lt1`      | letreiro da linha, sentido 2
| `p.l[n].qv`       | quantidade de veículos com previsão na lista `vs`
| `p.l[n].sl`       | sentido da linha nas previsões \[1|2\]
| `p.l[n].vs`       | lista dos próximos veículos que passarão na parada
| `p.l[n].vs[m].a`  | acessibilidade \[true\|false\]
| `p.l[n].vs[m].p`  | prefixo do veículo
| `p.l[n].vs[m].px` | longitude atual do veículo
| `p.l[n].vs[m].py` | latitude atual do veículo
| `p.l[n].vs[m].t`  | previsão de chegada na parada (HH:MM)
