#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <signal.h>


int nsock;
int msg_len = 50;

void catchsig(int sig)
{
	printf("Чат закрывается!\n");
	exit(0);
}

int main () {

	static struct sigaction act;
	act.sa_handler = catchsig;
	sigset_t set;
	sigemptyset(&set);
	sigaddset(&set, SIGTERM);
	act.sa_mask = set;
	sigaction(SIGTERM, &act, 0);

	FILE * f = fopen("addr", "r");
	char ip_address[10];
	int port;
	fscanf(f, "%s %d", ip_address, &port);
	fclose(f);

	int sockfd;

	struct sockaddr_in server;
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(port);

	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
		perror("socket error");
		exit(1);
	}

	if (bind(sockfd, (struct sockaddr *) &server, sizeof(server)) == -1) {
		perror("bind error");
		exit(1);
	}

	if (listen(sockfd, 1) == -1) {
		perror("listen error");
		exit(1);
	}

	char c;
	int nsock;
	
	printf("Ждем пока подключится второй собеседник!\n");
	
	for (;;) {
		nsock = accept(sockfd, NULL, NULL);
		if (nsock < 0)
		{
			printf("Error with accept!");
		}
		else
		{	
			printf("К чату присоединился второй собеседник!\n");
			break;
		}
	}
	
	pid_t pid_parent = getpid();
	pid_t pid = fork();
	if (pid == 0) {
		char c[msg_len + 2];
		int bytes_recv = recv(nsock, c, msg_len + 2, 0);
		while ( bytes_recv > 0) {
			printf("\nСобеседник: %s", c);
			printf("Вы: ");
			fflush(stdout);
			int j;
			bytes_recv = recv(nsock, c, msg_len + 2, 0);
			
		}
		close(nsock);
		printf("\nОтсоединился собеседник!\n");
		kill(pid_parent, SIGTERM);
		exit(0);
	}
	else
	{
			char buf[msg_len + 2];
			int c = 0;
			int i = 0;
			printf("Вы: ");
			while (c != 27)
			{
				c = getchar();
				if (i <= msg_len)
				{
					buf[i++] = c;
				}
				else
				{
					++i;
					printf("Слишком длинное сообщение!\n");
					while (c != 10)
					{
						c = getchar();
					}
					printf("Вы: ");
				}
				if (c == 10)
				{
					if ((i > 1) && (i <= msg_len + 1))
					{
						buf[i] = 0;
						//send message
						send(nsock, buf, msg_len + 2, 0);
						printf("Вы: ");

					}
					i = 0;
				}
			}
			printf("Вы закрыли чат!\n");
			kill(pid, SIGKILL);
	}
	printf("Чат закрывается!\n");
	return 0;
}
