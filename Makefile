# Change these to match your source code.
TARGET	= glupy.so
OBJECTS	= glupy.o

# Change these to match your environment.
GLFS_SRC  = /root/glusterfs_patches
GLFS_ROOT = /usr/lib64
GLFS_VERS = 3git
HOST_OS  = GF_LINUX_HOST_OS

# You shouldn't need to change anything below here.

CFLAGS	= -fPIC -Wall -O0 -g \
	  -DHAVE_CONFIG_H -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D$(HOST_OS) \
	  -I$(GLFS_SRC) -I$(GLFS_SRC)/libglusterfs/src \
	  -I$(GLFS_SRC)/contrib/uuid -I.
LDFLAGS	= -shared -nostartfiles -L$(GLFS_ROOT) -lglusterfs \
	  -lpthread -lpython2.6

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -o $(TARGET)

install: $(TARGET)
	cp $(TARGET) $(GLFS_ROOT)/glusterfs/$(GLFS_VERS)/xlator/features/

clean:
	rm -f $(TARGET) $(OBJECTS)
