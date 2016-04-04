#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <arpa/inet.h>
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

	int sockfd;

	FILE * f = fopen("addr", "r");
	char ip_address[10];
	int port;
	fscanf(f, "%s %d", ip_address, &port);
	fclose(f);	
	
	struct sockaddr_in server;
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr(ip_address);
	server.sin_port = htons(port);

	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
		perror("socket error");
		exit(1);
	}
	
	if (connect(sockfd, (struct sockaddr *) &server, sizeof(server)) == -1) {
		perror("connect error");
		exit(1);
	}
	
	pid_t pid_parent = getpid();
	pid_t pid = fork();
	if (pid == 0) {
		char c[msg_len + 2];
		int bytes_recv = recv(sockfd, c, msg_len + 2, 0);
		while ( bytes_recv > 0) {
			printf("\nСобеседник: %s", c);
			printf("Вы: ");
			fflush(stdout);
			int j;
			bytes_recv = recv(sockfd, c, 81, 0);
			
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
					buf[i] = '\0';
					//send message
					send(sockfd, buf, msg_len+2, 0);
					printf("Вы: ");

				}
				i = 0;
			}
		}
		printf("Вы закрыли чат!\n");
		kill(pid, SIGKILL);
	}
	return 0;
}
