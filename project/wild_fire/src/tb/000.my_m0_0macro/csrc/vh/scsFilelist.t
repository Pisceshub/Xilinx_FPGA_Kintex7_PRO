#include "stdio.h"
#ifdef __cplusplus
extern "C" {
#endif
extern char at_least_one_object_file;
extern void *kernel_scs_file_ht_new(const void *, int);
extern int kernel_scs_file_ht_get(void *, const char *, int *);
extern int  strcmp(const char*, const char*);
  typedef struct {
    char* dFileName;
  } lPkgFileInfoStruct;

  typedef struct {
    char* dFileName;
    char* dRealFileName;
    long dFileOffset;
    unsigned long dFileSize;
    int dFileModTime;
    unsigned int simFlag;
  } lFileInfoStruct;

static int lNumOfScsFiles;
  static lFileInfoStruct lFInfoArr[] = {
  {"synopsys_sim.setup_0", "/home/ICer/synopsys_sim.setup", 76398, 34060, 1696499064, 0},
  {"synopsys_sim.setup_1", "/home/ICer/Work_file/VCSVerdi/K7_vcs_lib/synopsys_sim.setup", 110458, 37471, 1692088370, 0},
  {"synopsys_sim.setup_2", "/home/synopsys/vcs-mx/O-2018.09-1/bin/synopsys_sim.setup", 147929, 3536, 1539412377, 0},
  {"linux64/packages/synopsys/lib/64/NOVAS__.sim", "", 0, 76398, 0, 0},
  {"linux64/packages/synopsys/lib/64/NOVAS.sim", "", 151465, 50089, 0, 0},
