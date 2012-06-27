#include <memory>

class TEST_PTR
{
public:
	TEST_PTR(): i(42) {}
	TEST_PTR(TEST_PTR&& other): i(other.i) {}
	
	int i;
};

int main()
{
	std::shared_ptr<TEST_PTR> ptr( new TEST_PTR );
	std::shared_ptr<TEST_PTR> moved( std::move( ptr ) );

	auto atr = moved->i;

	return atr;
}
