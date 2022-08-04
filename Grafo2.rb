class Grafo

    def initialize( )
        @cantidad_nodos = 0
        @estructura = {}
        @valores = {}
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
            @estructura[b].append(a)
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
        Fiber.new do
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
                                Fiber.yield pila
                        end
                    else
                        i = i + 1
                    end
                end
                pila.pop()
            end
        end
    end 
end

def main
  continua = true
  grafo = Grafo.new
  nodoAlmacenado = nil
  while continua
    print '~'
    b = gets.chomp
    if b =~ /NUEVOGRAFO/
      b.slice! 'NUEVOGRAFO'
      array = b.split(' ', -1)
      if array.length > 0
        puts 'No acepta'
      else
        grafo = Grafo.new
      end
    end
    if b =~ /NODO/
      b.slice! 'NODO'
      array = b.split(' ', -1)
      if array.length > 2
        puts 'Solo se debe insertar el nodo y su informacion'
      else
        res = grafo.agregar_nodo(array[0], array[1])
        if res
          puts 'Se ha introducido el nodo ' + array[0]
        else
          puts 'El nodo ' + array[0] + ' ya existe'
        end
      end
    end
    if b =~ /LADO/
      b.slice! 'LADO'
      array = b.split(' ', -1)
      if array.length > 2
        puts 'El lado solo contiene dos vertices'
      else
        res = grafo.agregar_arista(array[0], array[1])
        if res
          puts 'Se ha introducido el lado (' + array[0] + ',' + array[1] + ')'
        else
          puts 'No puede introducir el lado (' + array[0] + ',' + array[1] + '), alguno de los nodos no existe'
        end
      end
    end
    if b =~ /BUSCAR/
      b.slice! 'BUSCAR'
      array = b.split(' ', -1)
      if array.length > 1
        puts 'Solo se puede hacer la busqueda de la informacion de un nodo'
      else
        recorrido = a.camino(0, array[0])
        path =  recorrido.resume
        if path[path.length-1].length !=0
          nodoAlmacenado = path[path.length-1][0]
        else
          nodoAlmacenado = 0
        end
        puts path
      end
    end
    if b =~ /ITERAR/
      b.slice! 'ITERAR'
      array = b.split(' ', -1)
      if array.length > 1
        puts 'Solo se puede hacer la busqueda de la informacion de un nodo'
      else
        adyacentes = grafo.adyacentes(nodoAlmacenado)
        recorrido = grafo.camino(adyacentes[0], array[0])
        puts recorrido.resume
      end
    end
    if b =~ (/SALIR/) || b =~ (/salir/)
      continua = false
      puts 'Has salido!'
    end
  end
end
main
