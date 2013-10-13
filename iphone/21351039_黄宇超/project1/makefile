mycal:main.m MyCal.m
	clang -framework foundation main.m MyCal.m -o main
run:
	./main cal	
	./main cal 12 2008
	./main cal -m 02
	./main cal 2000
error:
	./main
	./main cal 100000
	./main cal 13 2013
	./main cal 10 100000
	./main cal -m 13
clean:
	rm main
