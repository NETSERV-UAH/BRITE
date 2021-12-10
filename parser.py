#!/usr/bin/python3
import sys

def parseador(path):
    split_path = path.split('/')
    num_linea = 0 #La vamos incrementando a cada linea que leemos. Me sirve para ir viendo en que linea del archivo me encuentro
    Carpeta_brite = split_path[0]
    modelo = split_path[1]
    n_nodos = split_path[2]
    grado = split_path[3]
    semilla = split_path[4]
    linea_primer_nodo = 4 #Linea con la información del primer nodo 
    linea_ultimo_nodo = linea_primer_nodo + int(n_nodos) -1 #Linea con la información del último nodo
    linea_primer_edge = linea_ultimo_nodo + 3 #Linea con la información del primer enlace
    lista_nodos = list()
    lista_enlaces = list()
    with open(path, 'r') as file:
        for datos_lectura in file.readlines():
            if num_linea >= linea_primer_nodo and num_linea <= linea_ultimo_nodo: #tratamos los nodos
                info_nodos = dict()
                info_nodos["ID"] = datos_lectura.split()[0]
                info_nodos["x_pos"] = datos_lectura.split()[1]
                info_nodos["y_pos"] = datos_lectura.split()[2]
                lista_nodos.append(info_nodos)
            elif num_linea >= linea_primer_edge:
                info_enlaces = dict()
                info_enlaces["from"] = datos_lectura.split()[1]
                info_enlaces["to"] = datos_lectura.split()[2]
                info_enlaces["distancia"] = datos_lectura.split()[3]
                lista_enlaces.append(info_enlaces)
            num_linea +=1
    #Crear archivo nodos
    archivo_nodos = Carpeta_brite +'/'+ modelo  +'/'+ n_nodos +'/'+ grado +'/'+ semilla +'/'+'Nodos.txt'
    with open(archivo_nodos, 'w') as file:
        for info_nodos in lista_nodos:
            file.write(info_nodos["ID"]+';'+info_nodos["x_pos"]+';'+info_nodos["y_pos"]+'\n') #Pregunta: ¿pongo un ; al final de cada linea?

    #Crear archivo enlaces
    archivo_enlaces = Carpeta_brite +'/'+ modelo  +'/'+ n_nodos +'/'+ grado +'/'+ semilla +'/'+'Enlaces.txt'
    with open(archivo_enlaces, 'w') as file:
        for info_enlaces in lista_enlaces:
            file.write(info_enlaces["from"]+';'+info_enlaces["to"]+';'+info_enlaces["distancia"]+'\n') #Pregunta: ¿pongo un ; al final de cada linea?

if __name__ == "__main__":
    parseador(sys.argv[1])
