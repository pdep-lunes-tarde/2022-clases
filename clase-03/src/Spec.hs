module Spec where
import PdePreludat
import Library
import Test.Hspec

ochoRojo = CartaNumerica 8 Rojo
sieteAzul = CartaNumerica 7 Azul

sieteVerde :: Carta
sieteVerde = CartaNumerica 7 Verde

reversaVerde :: Carta
reversaVerde = CartaEspecial Reversa Verde

reversaRojo :: Carta
reversaRojo = CartaEspecial Reversa Rojo

saltarTurnoRojo :: Carta
saltarTurnoRojo = CartaEspecial SaltarTurno Rojo

mas4Rojo :: Carta
mas4Rojo = CartaEspecial Mas4 Rojo

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de clase 3" $ do
    it "una carta se puede jugar despues de otra si coinciden sus numeros" $ do
      sePuedeJugar ochoAzul ochoRojo `shouldBe` True
    it "una carta no se puede jugar despues de otra si no coinciden sus numeros ni sus colores" $ do
      sePuedeJugar ochoAzul sieteVerde `shouldBe` False
    it "una carta se puede jugar despues de otra si coinciden sus colores" $ do
      sePuedeJugar ochoAzul sieteAzul `shouldBe` True
    it "una carta especial se puede jugar sobre otra carta especial si tiene la misma figura" $ do
      sePuedeJugar reversaVerde reversaRojo `shouldBe` True
    it "una carta especial se puede jugar sobre otra carta especial si tiene el mismo color" $ do
      sePuedeJugar reversaRojo saltarTurnoRojo `shouldBe` True
    it "una carta especial no se puede jugar sobre otra carta especial si no tiene misma figura ni mismo color" $ do
      sePuedeJugar reversaVerde saltarTurnoRojo `shouldBe` False
    it "siempre se puede jugar una carta de mas 4 por sobre otra carta" $ do
      sePuedeJugar sieteAzul mas4Rojo `shouldBe` True
    it "puedo jugar una carta sobre un mas 4 solo si es del color del mas 4" $ do
      sePuedeJugar mas4Rojo reversaRojo `shouldBe` True
    it "no puedo jugar una carta sobre un mas 4 si es de diferente color que el mas 4" $ do
      sePuedeJugar mas4Rojo sieteAzul `shouldBe` False
