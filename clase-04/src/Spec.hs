module Spec where
import PdePreludat
import Library
import Test.Hspec

unoRojo = CartaNumerica 1 Rojo
dosVerde = CartaNumerica 2 Verde
tresAzul = CartaNumerica 3 Azul
cuatroAmarillo = CartaNumerica 4 Amarillo 

manoVacia :: [Carta]
manoVacia = []

listaDeColoresVacia :: [Color]
listaDeColoresVacia = []

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de clase 4" $ do
    describe "ultimaCarta" $ do
      it "si le pasamos una lista con solo una carta, nos devuelve esa carta" $ do
        ultimaCarta [unoRojo] `shouldBe` unoRojo
      it "si le pasamos una lista con cartas, nos devuelve la ultima" $ do
        ultimaCarta [unoRojo, dosVerde] `shouldBe` dosVerde
    describe "primeras" $ do
      it "si le pasamos 0, nos devuelve una lista vacia sin importar las cartas que le hayamos pasado" $ do
        primeras 0 [unoRojo, dosVerde] `shouldBe` manoVacia
      it "si le pasamos una lista vacia, nos devuelve una lista vacia" $ do
        primeras 2 manoVacia `shouldBe` manoVacia
      it "si le pedimos mas cartas de las que hay en la lista, nos devuelve la lista entera" $ do
        primeras 5 [unoRojo, dosVerde] `shouldBe` [unoRojo, dosVerde]
      it "si le pasamos 1, nos devuelve una lista con el primer elemento" $ do
        primeras 1 [unoRojo, dosVerde] `shouldBe` [unoRojo]
      it "nos devuelve una lista con las primeras n cartas" $ do
        primeras 3 [unoRojo, dosVerde, tresAzul, cuatroAmarillo] `shouldBe` [unoRojo, dosVerde, tresAzul]
    describe "cartasAColores" $ do
      it "si le pasamos una mano vacia, nos devuelve una lista vacia" $ do
        cartasAColores manoVacia `shouldBe` listaDeColoresVacia
      it "si le pasamos una mano con una carta, nos devuelve una lista con el color de esa carta" $ do
        cartasAColores [unoRojo] `shouldBe` [Rojo]
      it "si le pasamos una mano con varias cartas, nos devuelv una lista con cada uno de los colores de las cartas" $ do
        cartasAColores [unoRojo, dosVerde, tresAzul] `shouldBe` [Rojo, Verde, Azul]
