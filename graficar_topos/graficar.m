%extraer datos de los nodos y enlaces
nodes = importdata('Nodos.csv');
edges = importdata("Enlaces.csv");

%posicion nodos
posX_nodes = nodes(:,2)';
posY_nodes = nodes(:,3)';

from_node = edges(:,1)' + 1; 
to_node = edges(:,2)' + 1;
% '+1' es porque BRITE empieza a numerar por el nodo 0 y matlab empieza
% por el 1

g = graph(from_node,to_node);
plot(g, 'XData', posX_nodes, 'YData', posY_nodes);







