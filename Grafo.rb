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
