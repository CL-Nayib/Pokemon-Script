#!/bin/bash

#Verificacion
if [ $# -eq 0 ]; then
   echo "Primero proporciona el nombre de un pokemon"
   exit 1
fi

pokemon="$1"
#Tranliteracion para que todo sea minuscula
pokemon_lwr=$(echo "$pokemon" | tr [:upper:] [:lower:])

api_url="https://pokeapi.co/api/v2/pokemon/${pokemon_lwr}"

result=$(curl -s "${api_url}")

#Pokemon invalido
if [ "$( echo "$result" | jq -r .detail )" != "null" ]; then
    echo "No se encontró el Pokemon ${pokemon} "
    exit 1
fi

#Datos
pokedex_num=$(echo "$result" | jq -r .order) 
pokemon_id=$(echo "$result" | jq -r .id)
pokemon_weight=$(echo "$result" | jq -r .weight)
pokemon_height=$(echo "$result" | jq -r .height)

#Salida
echo "$pokemon (No. $pokedex_num)"  
echo "Id = $pokemon_id"
echo "Weight = $pokemon_weight"
echo "Height = $pokemon_height"