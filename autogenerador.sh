#!/bin/bash
#Script para automatizar la generacion de archivos brite
#Falta terminar
n_topologias_distintasxnodo=10
topologia=1  #RTWaxman
nodos=(10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200)
NodePlacement=(1 2)
GrowthType=1
m=(1 2 3 4 5 6)
alpha="0.15"
beta="0.2" #Como alpha y beta son del modelo Waxman no las voy a cambiar
for i in ${nodos[@]}
do
	for posicion_nodos in ${NodePlacement[@]}
	do
		for conectividad in ${m[@]}
		do 
		python3 generador_brite.py Archivos_confPrueba/archivoconf${i}x${posicion_nodos}x${conectividad}.conf $topologia $i $posicion_nodos $GrowthType $conectividad $alpha $beta
		for ((k=1; k<=10; k++))
		do
			bin/brite Archivos_confPrueba/archivoconf${i}x${posicion_nodos}x${conectividad}.conf Archivos_britePrueba/archivobrite${i}x${posicion_nodos}x${conectividad}x${k} seed_file
		done
		done
	done
done
