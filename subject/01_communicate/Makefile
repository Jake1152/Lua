NAME = lnc
CC = gcc
CFLAGS = -Wall -Wextra -Werror -I/usr/local/include/luajit-2.1 -L/usr/local/lib -lluajit-5.1 
RM = rm -f

SRCS = main.c
OBJS = $(SRCS:.c=.o)

%.o : %.c
	$(CC) $(CFLAGS) -c $^ -o $@

$(NAME) : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

all : $(NAME)

clean :
	$(RM) $(OBJS)

fclean : clean
	$(RM) $(NAME)

re :
	make fclean
	make all

.PHONY: all clean fclean re