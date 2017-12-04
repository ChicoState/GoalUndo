all : clean
	g++ Goalundo.cpp example.cpp -o example

clean :
	rm -f *.o a.out example
