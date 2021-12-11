#!/usr/bin/python3
import sys

def generador(lista):    #path, name, N, NodePlacement, GrowthType, m, alpha, beta
    """
        Función que genera el archivo de configuración para BRITE
        Entrada de Waxma: path, name, N, NodePlacement, GrowthType, m, alpha, beta
        Entrada de Barabasi: path name, N, NodePlacement, m
    """
    with open(lista[1], 'w') as file:
        file.write('BriteConfig\n\nBeginModel\n')
        file.write('\tName = ' + str(lista[2]) + '\n')  #Router Waxman = 1, AS Waxman = 3 Router Barabasi=2, AS Barabasi =4
        file.write('\tN = ' + str(lista[3]) + '\n')    #Number of nodes in graph
        file.write('\tHS = 1000\n')  #Size of main plane (number of squares)
        file.write('\tLS = 100\n')  #Size of inner planes (number of squares)
        file.write('\tNodePlacement = ' + str(lista[4]) + '\n')    #Random = 1, Heavy Tailed = 2
        if (lista[2] == '1' or lista[2] == '3'):    #Es Waxman
            file.write('\tGrowthType = ' + str(lista[5]) + '\n')  #Incremental = 1, All = 2
            file.write('\tm = ' + str(lista[6]) + '\n')    #Number of neighboring node each new node connects to.
            file.write('\talpha = ' + str(lista[7]) + '\n')    #Waxman Parameter
            file.write('\tbeta = ' + str(lista[8]) + '\n')  #Waxman Parameter
        else: #Es Barbasi
            file.write('\tm = '+ str(lista[5]) + '\n')
        file.write('\tBWDist = 1\n')    #Constant = 1, Uniform =2, HeavyTailed = 3, Exponential =4
        file.write('\tBWMin = 10.0\n')
        file.write('\tBWMax = 1024.0\n')
        file.write('EndModel\n\n\n\n')
        file.write('BeginOutput\n')
        file.write('\tBRITE = 1\n\tOTTER = 0\n\tDML = 0\n\tNS = 0\n\tJavasim = 0\nEndOutput')


if __name__ == "__main__":
    generador(sys.argv)
