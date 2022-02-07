# TODO fill in description

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DEV_DATA := $(realpath $(ROOT_DIR)/data)
DEV_RESULTS:= $(realpath $(ROOT_DIR)/results)
#DEV_GFF_READ_EXECUTABLE := /home/scott/Documents/Uni/Research/gffread
#DEV_GFF_READ_EXECUTABLE := /mnt/research/edgerpat_lab/Scotty/gffread  # use if on HPCC

