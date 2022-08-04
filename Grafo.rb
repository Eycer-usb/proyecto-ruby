class Grafo

    def initialize( )
        @cantidad_nodos = 0
        @estructura = {}
    end


    def agregar_nodo( nombre )
        if not @estructura.has_key?( nombre )
            @estructura[nombre] = []
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

    def camino( a, b )

        # Inicializamos Todos los nodos como no visitados
        vistos = {}
        @estructura.each do | nombre, adyacentes|
            vistos[nombre] = false
        end
        # Inicializamos la pila
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
                    if ady == b
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
       puts "Introduce una entrada:"
       b = gets.chomp
       if b =~ /NUEVOGRAFO/
           b.slice! "NUEVOGRAFO"
           array = b.split(' ', -1)
           if (array.length()>0)
             puts "No acepta"
           else
             grafo = Grafo.new
           end
       end
       if b =~ /NODO/
           b.slice! "NODO"
           array = b.split(' ', -1)
           if (array.length()>1)
             puts "Solo se debe insertar el nodo"
           else
             grafo.agregar_nodo(array[0])
             puts "Se ha introducido el nodo "+array[0]
           end
       end
       if b =~ /LADO/
           b.slice! "LADO"
           array = b.split(' ', -1)
           if (array.length()>2)
             puts "El lado solo contiene dos vertices"
           else
             grafo.agregar_arista(array[0], array[1])
             puts "Se ha introducido el lado ("+array[0]+","+array[1]+")"
           end
       end
       if b =~ /BUSCAR/
           b.slice! "BUSCAR"
           array = b.split(' ', -1)
           if (array.length()>2)
             puts "Solo se puede hacer la busqueda entre 2 vertices"
           else
             puts grafo.camino(array[0],array[1])
           end
       end
       if b =~ /SALIR/
         continua = false
         puts "Has salido!"
       end 
   end
end
main()
'''
a = Grafo.new
a.agregar_nodo("hola")
a.agregar_nodo("mi")
a.agregar_nodo("gente")
a.agregar_nodo("bella")
a.agregar_nodo("amable")
a.agregar_arista("hola", "mi")
a.agregar_arista("mi", "gente")
a.agregar_arista("gente", "bella")
a.agregar_arista("gente", "amable")
a.imprimir()
puts a.camino("hola", "amable")
'''
