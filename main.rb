require_relative 'Grafo'
## La funcion main maneja las entradas del usuario, detecta errores en los string de entrada
# En caso de algun error, muestra un mensaje de error en la consola y si no, realiza las operaciones sobre el Grafo 
# El programa cuenta con varios comandos disponibles:
# NUEVOGRAFO hace reset del grafo para escribir uno nuevo sin reiniciar
# NODO x agrega el nodo x al grafo
# LADO x y agrega el lado x y al grafo
# SALIR sale del ciclo y termina el programa
# BUSCAR x y ejecuta el dfs
def main()
    continua = true
    grafo = Grafo.new
    nodoAlmacenado = nil
    i = 0
    print "Se ha creado un nuevo grafo\n"
    while continua
        print "~"
        b = gets.chomp
        b.strip!
        if (b == "") 
          next
        end
        array = b.split(' ', -1)
        if array[0].upcase == "NUEVOGRAFO"
            if (array.length()>1)
              puts "argumento invalido: " + array[1]
            else
              grafo = Grafo.new
              puts "se ha creado un nuevo grafo"
            end
        
        elsif array[0].upcase == "NODO"
            if (array.length() == 1) 
             puts "Falta el argumento <nodo>"
            elsif (array.length() == 2) 
             puts "Falta el argumento <informacion>"
            elsif (array.length()>3)
             puts "Argumento invalido: " + array[3]
            else
              res = grafo.agregar_nodo(array[1],array[2])
              if (res)
                puts "Se ha introducido el nodo "+array[1]
              else
                puts "El nodo "+array[1]+" ya existe"
              end
            end
        
        elsif array[0].upcase == "LADO"
            if (array.length()  == 1) 
              puts "Falta el argumento <nodo1>"
            elsif (array.length()  == 2) 
              puts "Falta el argumento <nodo2>"
            elsif (array.length()>3)
              puts "Argumento invalido: " + array[3]
            else
              res = grafo.agregar_arista(array[1], array[2])
              if (res)
                puts "Se ha introducido el lado ("+array[1]+","+array[2]+")"
              else
                puts "No puede introducir el lado ("+array[1]+","+array[2]+"), alguno de los nodos no existe"
              end
            end
        
        elsif array[0].upcase == "BUSCAR"
            if (array.length == 1)
              puts "Falta el argumento <informacion>"
            elsif (array.length()>2)
              puts "Argumento no reconocido: " + array[2]
            else
               recorrido = grafo.camino(grafo.obtenerPrimeraClave(), array[1])
               path =  recorrido.resume
             if path != nil and path[path.length-1].length !=0
               nodoAlmacenado = path[path.length-1][0]
               i = 0
               puts "A continuacion el Camino obtenido"
               puts path
               otro = true
               puts "Desea buscar otro nodo con el mismo valor?"
               while otro

                    puts "S/N\n~"
                    input = gets.chomp
                    input.upcase!
                    if input == "N"
                        otro = false
                    elsif input == "S"
                        path =  recorrido.resume
                        if path != nil and path[path.length-1].length !=0
                            nodoAlmacenado = path[path.length-1][0]
                            i = 0
                            puts "A continuacion el Camino obtenido"
                            puts path
                        else
                            puts "No hay mas nodos con este valor"
                            otro = false
                        end
                    elsif input != "N" and input != "S"
                        puts "Introduzca una respuesta Valida"
                    end
               end
             else
                if array[1] == grafo.obtenerPrimerValor()
                    nodoAlmacenado = [grafo.obtenerPrimeraClave(),array[1]]
                    puts nodoAlmacenado
                else
                    nodoAlmacenado = nil
                    puts "No se encontro ningun camino"
                end
             end
              
            end
         elsif array[0].upcase == "ITERAR"

           if (array.length > 1)
             puts "Argumento no reconocido: " + array[1]
           else
             if (nodoAlmacenado == nil)
               puts "No hay ningun nodo almacenado"
             else
               adyacentes = grafo.adyacentes(nodoAlmacenado)
  
               puts adyacentes[i]
               i = (i+1) % adyacentes.length
             end
           end
 
        elsif array[0].upcase == "SALIR"
          continua = false
          puts "Has salido!"
        else 
          puts "Comando no reconocido"
        end 
    end
 end
 main()
