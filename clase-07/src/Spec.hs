module Spec where
import PdePreludat
import Library
import Test.Hspec

vaca = Animal 10 Terrestre 100
tiburon = Animal 50 Acuatico 120

unaGranja = Granja [vaca, tiburon] [baya, baya, baya]
granjaChica = Granja [tiburon] [carne]

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de clase 7" $ do
    describe "Granja" $ do
      it "mostrar una granja me deberia devolver un string que diga que animales tiene y cuantos alimentos" $ do
        show unaGranja `shouldBe` "Una granja con los siguientes animales: Animal {energia = 10, tipo = Terrestre, peso = 100}, Animal {energia = 50, tipo = Acuatico, peso = 120} y 3 alimentos"
      it "una granja es mayor a otra si tiene mas animales" $ do
        unaGranja > granjaChica