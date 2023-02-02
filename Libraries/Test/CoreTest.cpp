#include "gtest/gtest.h"

#include "Vector2f.h"

TEST(VectorMath, Length) {
	Vector2f v1{ 3,4 };
	EXPECT_EQ(v1.Length(), 5);
	EXPECT_EQ(v1.Norm(), 5);

	Vector2f v2{ 7,8 };
	EXPECT_EQ(v2.Length(), 10.6301460f);
	EXPECT_EQ(v2.Norm(), 10.6301460f);
}

TEST(VectorMath, Operators)
{
	Vector2f v1{ 3,4 };
	Vector2f v2 = 3 * v1;
	EXPECT_EQ(v2.x, 9);
	EXPECT_EQ(v2.y, 12);

	Vector2f v3 = v1 * 4;
	EXPECT_EQ(v3.x, 12);
	EXPECT_EQ(v3.y, 16);
}