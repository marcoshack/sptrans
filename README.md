# Olho Vivo SPTrans

O site [Olho Vivo da SPTrans](http://olhovivo.sptrans.com.br/) oferece informações sobre a localização dos ônibus em uma série de linhas da capital Paulista.

Esse projeto visa documentar a API web utilizada pelo site, que basicamente é uma aplicação JavaScript estática, para que, se autorizado pela SPTrans, possa ser utilizada por outras aplicações.

**IMPORTANTE**: Esse projeto não tem relação alguma com a SPTrans. Não temos informações sobre a possibilidade de utilizar a API em aplicações de terceiros. Entre em contato com a SPTrans antes de utilizar esses recursos.

# API

Todos os recursos retornam uma representação no formado JSON (`Content-Type: application/json; charset=utf-8`).

## Paradas

Listagem e busca das paradas de ônibus monitoradas pelo programa Olho Vivo. 

    http://200.189.189.54/InternetServices/BuscaParadasSIM[?termosBusca={termo}]

O valor do parâmetro `termosBusca` será comparado com os atributos `Endereco` e `Nome` do recurso, p.ex.:

    curl http://200.189.189.54/InternetServices/BuscaParadasSIM?termosBusca=paulista

retornará o seguinte resultado:

    {
      "BuscaParadasSIMResult": [
        {
          "CodigoParada": 260015039,
          "Endereco": " AV PAULISTA\/ AV REBOUCAS ",
          "Latitude": -23.555883,
          "Longitude": -46.66306,
          "Nome": "PAULISTA BC"
        },
        {
          "CodigoParada": 260016855,
          "Endereco": "AV PAULISTA\/ R ANTONIO CARLOS",
          "Latitude": -23.555176,
          "Longitude": -46.66237,
          "Nome": "PAULISTA CB"
        }
      ]
    }

Se o parâmetro `termosBusca` for omitido será retornada a lista completa de paradas.


## Linhas

Busca por linhas de ônibus.

    http://200.189.189.54/InternetServices/BuscaLinhasSIM?termosBusca={termo}

Nesse recurso o parâmetro `termosBusca` é obrigatório e será comparado ao atributos `DenominacaoTPTS` e `DenominacaoTSTP`, que são os nomes exibidos no letreiro dos ônibus da linha em cada sentido.

Exemplo:

    curl http://200.189.189.54/InternetServices/BuscaLinhasSIM?termosBusca=imirim

retornará o seguinte resultado:

    {
      "BuscaLinhasSIMResult": [
        {
          "Circular": false,
          "CodigoLinha": 568,
          "DenominacaoTPTS": "PINHEIROS",
          "DenominacaoTSTP": "IMIRIM",
          "Informacoes": null,
          "Letreiro": "967A",
          "Sentido": 1,
          "Tipo": 10
        },
        {
          "Circular": false,
          "CodigoLinha": 33336,
          "DenominacaoTPTS": "PINHEIROS",
          "DenominacaoTSTP": "IMIRIM",
          "Informacoes": null,
          "Letreiro": "967A",
          "Sentido": 2,
          "Tipo": 10
        }
      ]
    }


## Previsão

Previsão de chegada dos próximos ônibus de cada uma das linhas que atendem essa parada.

    http://200.189.189.54/InternetServices/Previsao?codigoParada={codigo_parada}

O parâmetro `codigoParada`, como o nome sugere, deve receber o valor indicado no atributo `CodigoParada` do recurso Parada. Por exemplo, o código da parada do cruzamento da Av. Paulista com a Rebolças é `260015039`, para consultar a previsão dos próximos ônibus nessa parada:

    curl http://200.189.189.54/InternetServices/Previsao?codigoParada=260015039

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
