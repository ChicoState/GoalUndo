  /**
   * NAME : Rahul Shinde
   * EXAM : Unit Tests for GoalUndo class
  **/

  #include <gtest/gtest.h>
  #include "GoalUndo.h"

  class GoalUndoTest : public ::testing::Test
  {
  	protected:
  		GoalUndoTest(){}
  		virtual ~GoalUndoTest(){}
  		virtual void SetUp(){}
  		virtual void TearDown(){}
  };

  //Test case 1: test that a new operation can be added
  TEST(GoalUndoTest, addFirstOperation)
  {
    GoalUndo goalObj;
    goalObj.addOperation("Draw-Square","draw-line");
    ASSERT_EQ("draw-line", goalObj.getOperations());
  }

  //Test case 2: test that a new operation without a goal adds nothing
  TEST(GoalUndoTest, addOperationWithoutGoal)
  {
    GoalUndo goalObj;
    goalObj.addOperation("","operation");
    ASSERT_EQ("", goalObj.getOperations() );
  }
