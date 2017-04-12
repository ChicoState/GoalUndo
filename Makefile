# Building GoogleTest and running exercise-gtest unit tests against
# all code in SOURCECODE subdirectory. This Makefile is based on the
# sample Makefile provided in the official GoogleTest GitHub Repo v1.7

# Points to the root of Google Test. Change it to reflect where your
# clone of the googletest repo is
GTEST_DIR = /usr/local/include/gtest

# Flags passed to the preprocessor and compiler
CPPFLAGS += -std=c++11 --coverage -isystem $(GTEST_DIR)/include
CXXFLAGS += -g -Wall -Wextra -pthread

# All tests produced by this Makefile.
TESTS = GoalUndoTest MutationGoalUndoTest

# All Google Test headers. Adjust only if you moved the subdirectory
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h

# House-keeping build targets.

all : clean $(TESTS) mutation coverage

clean :
	rm -f $(TESTS) gtest.a gtest_main.a *.o *.gcov *.gcda *.gcno

test : clean $(TESTS)
	@echo ----------TESTS ON CORRECT SOLUTION----------
	./GoalUndoTest

coverage : test
	@echo ----------COVERAGE ON CORRECT SOLUTION----------
	gcov -b GoalUndo.cpp
#	cat GoalUndo.cpp.gcov

mutation :
	@echo ----------TESTS ON MUTANTS----------
	./MutationGoalUndoTest

# Builds gtest.a and gtest_main.a.
GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

gtest-all.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
    $(GTEST_DIR)/src/gtest-all.cc

gtest_main.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
    $(GTEST_DIR)/src/gtest_main.cc

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

# Builds the MutationGoalUndoTest
MutationGoalUndo.o : MutationGoalUndo.cpp GoalUndo.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c MutationGoalUndo.cpp

MutationGoalUndoTest : MutationGoalUndo.o GoalUndoTest.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@

# Builds the GoalUndo and associated tests
GoalUndo.o : GoalUndo.cpp GoalUndo.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c GoalUndo.cpp

GoalUndoTest.o : GoalUndoTest.cpp \
                     GoalUndo.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c GoalUndoTest.cpp

GoalUndoTest : GoalUndo.o GoalUndoTest.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@