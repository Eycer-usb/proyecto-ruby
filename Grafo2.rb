class Grafo

    def initialize( )
        @cantidad_nodos = 0
        @estructura = {}
        @valores = {}
        @recorrido = nil
    end

    # Crea un Nodo con clave y Valor
    def agregar_nodo( clave, valor )
        if not @estructura.has_key?( clave )
            @estructura[clave] = []
            @valores[clave] = valor
            @cantidad_nodos = @cantidad_nodos + 1
            return true
        end
        return false
    end
        
    # Se reciben las claves de los nodos y se inserta
    # la arista correspondiente entre los dos nodos
    def agregar_arista( a, b )
        if @estructura.has_key?(a) and @estructura.has_key?(b)
            @estructura[a].append(b)
            return true
        else
            return false
        end
    end

    # Se imprime la estructura del grafo
    def imprimir()
        puts @estructura
    end

    # Dada una clave se retornan la lista
    # de adyacencias
    def adyacentes( a )
        if @estructura.has_key?(a)
            return @estructura[a]
        else
            return []
        end
    end

    
    # Se reciben la clave de un nodo digamos 'a' como primer argumento
    # y como segundo argumento un valor digamos 'v'. Se retornara
    # cada vez que se ejecute, el camino desde el nodo 'a' hasta un nodo
    # con valor 'v' en una lista de pares clave valor 
    def camino( a, b )
        # Inicializamos Todos los nodos como no visitados
        vistos = {}
        @estructura.each do | nombre, adyacentes|
            vistos[nombre] = false
        end
        # Inicializamos la pila de nodos
        valor_a = @valores[a]
        pila = [[a,valor_a]]
        vistos[a] = true
        while pila.length > 0
            actual = pila.last()[0]
            adyacentes = adyacentes(actual)
            i = 0
            n = adyacentes.length
            while i < n
                ady = adyacentes[i]
                if not vistos[ady]
                    vistos[ady] = true
                    valor_ady = @valores[ady]
                    pila.push([ady, valor_ady])
                    i = 0
                    n = @estructura[ady].length
                    actual = pila.last()[0]
                    adyacentes = adyacentes(actual)
                    if valor_ady == b
                        @recorrido = Fiber.new do
                            Fiber.yield pila
                        end
                        
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
a.agregar_nodo(0, "hola")
a.agregar_nodo(1, "mi")
a.agregar_nodo(2, "gente")
a.agregar_nodo(3, "amable")
a.agregar_nodo(4, "amable")
a.agregar_arista(0, 1)
a.agregar_arista(1, 2)
a.agregar_arista(2, 3)
a.agregar_arista(2, 4)
a.imprimir()
puts a.camino(0, "amable").resume
puts a.camino(0, "amable").resume
