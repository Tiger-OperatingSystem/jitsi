from random_word import RandomWords
import webbrowser

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

def url_jitsi():
    url_base = "https://meet.jit.si/"
    url_final = url_base + gerar_nome_reuniao()
    return url_final

def main():
    # Teste para abrir o browser
    webbrowser.open_new(url_jitsi())
    
if __name__ == '__main__':
    main()


