class Grafo

    def initialize( )
        @cantidad_nodos = 0
        @informacion = {}
        @estructura = {}
    end


    def agregar_nodo( nombre , info )
        if not @estructura.has_key?( nombre )
            @estructura[nombre] = []
            @informacion[nombre] = info
            @cantidad_nodos = @cantidad_nodos + 1
            return true
        end
        return false
    end
        

    def agregar_arista( a, b )
        if @estructura.has_key?(a) and @estructura.has_key?(b)
            @estructura[a].append(b)
            @estructura[b].append(a)
            return true
        else
            return false
        end
    end


    def imprimir()
        puts @estructura
    end

    def adyacentes( a )
        if @estructura.has_key?(a)
            return @estructura[a]
        else
            return []
        end
    end

    def camino(info)

        # Inicializamos Todos los nodos como no visitados
        vistos = {}
        @estructura.each do | nombre, adyacentes|
            vistos[nombre] = false
        end
        # Inicializamos la pila
        a = @estructura.keys.first
        pila = [a]
        vistos[a] = true
        while pila.length > 0
            actual = pila.last()
            adyacentes = adyacentes(actual)
            i = 0
            n = adyacentes.length
            while i < n
                ady = adyacentes[i]
                if not vistos[ady]
                    vistos[ady] = true
                    pila.push(ady)
                    i = 0
                    n = @estructura[ady].length
                    actual = pila.last()
                    adyacentes = adyacentes(actual)
                    if @informacion[ady] == info
                        return pila
                    end
                else
                    i = i + 1
                end
            end
            pila.pop()
        end

    end
end

# NUEVOGRAFO hace reset del grafo para escribir uno nuevo sin reiniciar
# NODO x agrega el nodo x al grafo
# LADO x y agrega el lado x y al grafo
# SALIR sale del ciclo y termina el programa
# BUSCAR x y ejecuta el dfs
def main()
   continua = true
   grafo = Grafo.new
   nodoAlmacenado = nil
   print "se ha creado un nuevo grafo\n"
   while continua
       print "~"
       b = gets.chomp
       b.strip!
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
              recorrido = grafo.camino(0, array[1])
              path =  recorrido.resume
            if path[path.length-1].length !=0
              nodoAlmacenado = path[path.length-1][0]
            else
              nodoAlmacenado = 0
            end
              puts path
            end
        elsif array[0].upcase == "ITERAR"
          if (array.length() == 1) 
            puts "Falta el parametro <informacion>"
          elsif (array.length > 2)
            puts "Argumento no reconocido: " + array[2]
          else
            adyacentes = grafo.adyacentes(nodoAlmacenado)
            recorrido = grafo.camino(adyacentes[0], array[1])
            puts recorrido.resume
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
