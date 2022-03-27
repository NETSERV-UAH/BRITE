#!/bin/bash
#Script para automatizar la generacion de archivos brite

dir_topos="topos"
n_topologias_distintasxnodo=10
topologia_rt_waxman=1  #RTWaxman
topologia_rt_barabasi=2  #RTBarabasi
nodos=$(seq 10 10 200)
NodePlacement=1 #1=all 2=HeavyTailed
m=(1 2 3) #Vamos a poner solo 1, 2 y 3 porque luego el grado es 2, 4, 6
#parametros especificos de waxman
GrowthType=1
alpha=0.2
beta=0.15

#crear carpetas donde se almacenan los archivos de configuración de brite
mkdir -p Archivos_conf_Waxman
mkdir -p Archivos_conf_Barabasi

for num_nodos in ${nodos[@]}
do
	for conectividad in ${m[@]}
	do 
		grado=$(expr ${conectividad} \* 2)

		#generar configuracion waxman
		python3 generador_brite.py Archivos_conf_Waxman/archivoconf${num_nodos}x${conectividad}.conf $topologia_rt_waxman $num_nodos $NodePlacement $GrowthType $conectividad $alpha $beta

		#generar configuracion barabasi
		python3 generador_brite.py Archivos_conf_Barabasi/archivoconf${num_nodos}x${conectividad}.conf $topologia_rt_barabasi $num_nodos $NodePlacement $conectividad 

		#Como brite modifica seed de manera automática utlizamos seed creadas por nosotros. Por cada iteración una seed distinta.
		#Cuando finaliza el bucle for se han modificado todas las seeds por ello se copian los archivos seed de inicio, para que siempre se utilice el mismo seed. 
		cp Carpeta_seeds_backup/* Carpeta_seeds

		for ((semilla=1; semilla<=$n_topologias_distintasxnodo; semilla++))
		do	
			mkdir -p $dir_topos/barabasi-${num_nodos}-${grado}/seed_${semilla} 
			mkdir -p $dir_topos/waxman-${num_nodos}-${grado}/seed_${semilla}
			
			#genenar brite para waxman
			bin/brite Archivos_conf_Waxman/archivoconf${num_nodos}x${conectividad}.conf $dir_topos/waxman-${num_nodos}-${grado}/seed_${semilla}/archivobrite Carpeta_seeds/seed${semilla}
			#Guardamos en el formato que queremos
			python3 parser.py $dir_topos/waxman-${num_nodos}-${grado}/seed_${semilla}/archivobrite.brite $dir_topos

			#utlizar mismo seed
			cp Carpeta_seeds_backup/* Carpeta_seeds

			#generar brite para barabasi
			bin/brite Archivos_conf_Barabasi/archivoconf${num_nodos}x${conectividad}.conf $dir_topos/barabasi-${num_nodos}-${grado}/seed_${semilla}/archivobrite  Carpeta_seeds/seed${semilla}
			#Guardamos en el formato que queremos
			python3 parser.py $dir_topos/barabasi-${num_nodos}-${grado}/seed_${semilla}/archivobrite.brite $dir_topos
		done
	done
done

