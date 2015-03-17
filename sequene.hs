import Data.List
import Control.Exception
import Text.Read
catchAny :: IO a -> (SomeException -> IO a) -> IO a
catchAny = Control.Exception.catch


factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial 1 = 1
factorial 2 = 1
factorial 3 = 1
factorial n = (factorial(n-1) + factorial (n - 2)) * factorial(n-3) `div` factorial(n-4)


split :: String -> Char -> [String]
split [] delim = [""]
split (x:xoxo) delim
   | x == delim = "" : rest
   | otherwise = (x : head rest) : tail rest
   where
       rest = split xoxo delim

sum1 :: (Integral a)=>a->a
sum1 0=1
sum1 1=2
sum1 2=3
sum1 3=4
sum1 n= factorial(n) + sum1(n-1)

listt t = map factorial[0..t]
	
isInteger s = case reads s :: [(Integer, String)] of
  [(_, "")] -> True
  _         -> False

main = do

   
    line <- getLine 
    let array1 = split line ' '                                     -- line :: String
    let cmd = head array1
    let num = last array1
    let arl = length array1
    let var2=read num :: Int
    if cmd=="QUIT"
	then do return()
	else do if isInteger num
		then do let abcd = read num :: Int
			if (arl/=2 ||abcd < 0)
			then do putStrLn "ERR"
				return()
			else do 
				if cmd == "NTH"
     				then do print (factorial abcd)
					main
        			else if cmd == "SUM"
				then do print(sum1 abcd)
					main
				else if cmd=="BOUNDS"
					then do if (abcd > 1)
						then do 
							let list = listt 25
							let newlist = insert abcd list
							let index = elemIndices abcd newlist 
							let realindex = head index
			 	
							let lowerbound = newlist !! (realindex-1)
							print lowerbound
							let upperbound = newlist !! (realindex + 1)
							if upperbound == abcd
								then do let var= newlist!!(realindex+2)
									print var
								else print upperbound
							main
						else do putStrLn "ERR" 				
							return()
			
				else putStrLn "ERR"
   		else do putStrLn "ERR"
                        return()
