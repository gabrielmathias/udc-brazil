#!/bin/bash

CRLF=`echo -e '\n\r'`
TAB=`echo -e '\t'`

arquivo=$1
saida=$2
erros="erros.txt"

# Remove as entradas de EXEMPLOS
cat "$arquivo" | \
grep -v "Exemplo(" | \

#Correcao do Apostrofe utilizado no word
gsed -E "s/\xe2\x80\x99/\`/" | \

# Corrige a letra l no lugar do 1 em alguns lugares
# no MAC eh preciso utilizar o gsed em vez do sed
gsed -E "s/(([0-9]+\.)+)(l[\.	])(.*)/\1\x31 \4/" | \
#sed -E $"s/(([0-9]+\.)+)(l   )(.*)/\{1}1\4/" | \

# Inclui as tags<06> e necessario ter TAB antes do CDU
sed -E $"s/^([	 ]+[0-9][^a-zA-Z]+)/\<06\>\1/" | \


sed -e "s/auxilia rés/auxiliares/g" | \

#Captura de exemplos:
gsed -E $"s/^(([0-9l\.\(\)])+[\:])+(.*)/<06\>\1\3/g" | \

#Captura do 01 e 02
gsed -E $"s/^(([0-9l\.\`\/])+)(.*)/\\$CRLF\<01\>\1\\$CRLF\<02\>\3/g" | \
#sed -E "s/(.*)[	]+(.*)/\1 \2/g"  | \

# Tudo que comecar por tab + seta eh exemplo <09>
sed -E "s/->[ ](.+)$/\<09\>\1/" | \

# linhas orfas, comecando sentenca avulsa serao consideradas <09>
sed -E "s/^([A-Z]+.+)$/\<09\>\1/" | \

# Retirando espaços em branco apos e antes do lancamento da TAG
sed -E "s/[ $TAB]+(\<[0-9][0-9]\>.*)$/\1/g"  | \
sed -E "s/(\<[0-9][0-9]\>)[ $TAB]+(.*)$/\1\2/g"  | \


#sed -E $"s/^[ ]+(.*)/\1/"  | \
#sed -E "s/>[ ]+/>/g"  | \

#sed -E "/^\b*$/d"  | \
#tr -d '\n\r' | \
#sed -e :a -e N -e 's/\n\r/ /' -e ta | \
#sed -E "s/(<[^<]+)/\1\\$CRLF/g" | \

#encontrando possiveis problemas:
sed -E "s/(<02>l.*)$/#ERRO1( l usado no lugar do 1 ?) \1/" | \
sed -E "s/(l.\d)$/#ERRO1( l usado no lugar do 1 ?) \1/" | \
sed -E "s/(.*[0-9][A-Z][a-z])(.*)$/#ERRO2(Texto orfao sem tag ?)  \1\2/" | \

#Consertando os finalizadores de linha
tr -d '\r' | \

tee $saida | \

egrep -i "<02>l " | \

tee $erros 2> /dev/null

echo "Erros:"

cat $erros
