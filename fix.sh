#!/bin/bash

ENTER=`echo -e '\n\r'`

arquivo="exemplo.txt"
saida="resultado.txt"
erros="erros.txt"

echo "Inserindo os <01>"

# Inclui as tags<06> e necessario ter TAB antes do CDU
sed -E $"s/^([	 ]+[0-9][^a-zA-Z 	]+)/\<06\>\1/" $arquivo | \

# Remove as entradas de EXEMPLOS
grep -v "Exemplo(" | \
sed -E "s/(.*)[	]+(.*)/\1 \2/g"  | \

# Tudo que comecar por tab + seta eh exemplo <09>
#sed -E $"s/->([ 	]*)(.+)$/\<09\>\2/" | \
sed -E "s/->[ ](.+)$/\<09\> \1/" | \

sed -E $"s/^([0-9][^a-zA-Z 	]+)[ 	]*(.*)/\\$ENTER\<01\>\1\\$ENTER\<02\>\2/g" | \
sed -E $"s/(\<[0-9][0-9]\>)[]?[	]?[ ]?(.*)$/\1\2/g"  | \
sed -E "s// /g"  | \
sed -E $"s/^[ ]+(.*)/\1/"  | \
sed -E "s/>[ ]+/>/g"  | \
sed -E "s/(<02>l.*)$/#ERRO \1/" | \

tee $saida | \

grep -i "<02>l " | \

tee $erros 2> /dev/null

echo "Erros:"

cat $erros
