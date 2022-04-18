module Spec where
import PdePreludat
import Library
import Test.Hspec

unoRojo = CartaNumerica 1 Rojo
dosVerde = CartaNumerica 2 Verde

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de clase 4" $ do
    it "test de prueba" $ do
      2 + 2 `shouldBe` 4