from random_word import RandomWords

def gerar_nome_reuniao():
    global palavras_juntas
    r = RandomWords()
    lista_palavras = []
    
    for _ in range(3):
        palavra = r.get_random_word()
        if palavra:
            lista_palavras.append(palavra.capitalize())
    
    palavras_juntas = "".join(lista_palavras)
    return palavras_juntas

def main():
    # Teste para gerar o nome da reunião
    print(gerar_nome_reuniao())
    
if __name__ == '__main__':
    main()


