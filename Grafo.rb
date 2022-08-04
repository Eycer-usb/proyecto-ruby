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
   while continua
       print "~"
       b = gets.chomp
       b.strip!
       b.upcase!
       if b =~ /NUEVOGRAFO/
           b.slice! "NUEVOGRAFO"
           array = b.split(' ', -1)
           if (array.length()>0)
             puts "argumento invalido: " + array[0]
           else
             grafo = Grafo.new
             puts "se ha creado un nuevo grafo"
           end
       
       elsif b =~ /NODO/
           b.slice! "NODO"
           array = b.split(' ', -1)
           if (array.length() == 0) 
            puts "Falta el argumento <nodo>"
           elsif (array.length()>1)
            puts "Argumento invalido: " + array[1]
           else
             res = grafo.agregar_nodo(array[0],array[1])
             if (res)
               puts "Se ha introducido el nodo "+array[0]
             else
               puts "El nodo "+array[0]+" ya existe"
             end
           end
       
       elsif b =~ /LADO/
           b.slice! "LADO"
           array = b.split(' ', -1)
           if (array.length()  == 0) 
             puts "Falta el argumento <nodo1>"
           elsif (array.length()  == 1) 
             puts "Falta el argumento <nodo2>"
           elsif (array.length()>2)
             puts "Argumento invalido: " + array[2]
           else
             res = grafo.agregar_arista(array[0], array[1])
             if (res)
               puts "Se ha introducido el lado ("+array[0]+","+array[1]+")"
             else
               puts "No puede introducir el lado ("+array[0]+","+array[1]+"), alguno de los nodos no existe"
             end
           end
       
       elsif b =~ /BUSCAR/
           b.slice! "BUSCAR"
           array = b.split(' ', -1)
           if (array.length == 0)
             puts "Falta el argumento <nodo>"
           elsif (array.length()>1)
             puts "Argumento no reconocido: " + array[1]
           else
             puts grafo.camino(array[0])
           end
       
       elsif b =~ /SALIR/
         continua = false
         puts "Has salido!"
       else 
         puts "Comando no reconocido"
       end 
   end
end
main()
