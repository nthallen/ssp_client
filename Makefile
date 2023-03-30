SSP_SRCS = ssp_get.c tcp.c udp.c
SSP_OBJS = $(SSP_SRCS:.c=.o)
SSP_LOG_SRCS = ssp_log.c tcp.c udp.c ringdown.c
SSP_LOG_OBJS = $(SSP_LOG_SRCS:.c=.o)
SSP_SIM_SRCS = ssp_sim.c ringdown.c
SSP_SIM_OBJS = $(SSP_SIM_SRCS:.c=.o)
SSP_CMD_SRCS = ssp_cmd.c tcp.c udp.c
SSP_CMD_OBJS = $(SSP_CMD_SRCS:.c=.o)
SSP_RAW_SRCS = ssp_raw_log.c tcp.c udp.c ringdown.c
SSP_RAW_OBJS = $(SSP_RAW_SRCS:.c=.o)
LDLIBS=-L/usr/local/lib -lnl

all : ssp_log ssp_cmd

ssp_log : $(SSP_LOG_OBJS)
ssp_sim : $(SSP_SIM_OBJS)
ssp_cmd : $(SSP_CMD_OBJS)
ssp_get : $(SSP_OBJS)
ssp_raw_log : $(SSP_RAW_OBJS)

.PHONY : clean
clean :
	rm -f *.o ssp_log ssp_cmd ssp_raw_log
