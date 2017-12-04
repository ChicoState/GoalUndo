#include <iostream>
#include <string>
#include "GoalUndo.h"

using namespace std;

int main()
{
  GoalUndo todo;

  todo.addOperation("Load default file", "Load configurations");
  todo.addOperation("Verify template");
  todo.addOperation("Re-verify template)");
  todo.undoOperation(); //removes reverification
  todo.addOperation("Show template");
  todo.addOperation("Enable editing");
  todo.addOperation("Stylize","Apply color");
  todo.addOperation("Apply font");
  todo.undoGoal(); //removes all of Stylize goal
  cout<<todo.getOperations();
  return 0;
}