#include <iostream>
#include <string>
#include <vector>
#include <algorithm> // for_each
#include <functional> // function

using namespace std;

void example1();
void example2();
void example3();

int main() {

	example1();
	example2();
	example3();

	return 0;
}

// C++�� ���ٽ��� �����ϱ� ���� ����
void example1() {
	auto lambda1 = [](const string& a, const string& b) -> bool
	{ return a.size() < b.size();  };
	int sz = 10;
	// auto lambda2 = [sz](const string& a) { return a.size() >= sz;  };
	// capture list���� & ���
	auto lambda2 = [&sz](const string& a) { return a.size() >= sz;  };

	cout << lambda1("abc", "def ghi") << endl;

	cout << lambda2("hello") << endl;

	sz = 3;

	cout << lambda2("hello") << endl;
}

// ������ Ȱ�뿹 1��: ���ø��� ����
void example2() {
	vector<string> words;
	words.push_back("a");
	words.push_back("de");
	words.push_back("ghi");

	char c = ' ';
	ostream& os = cout;

	for_each(words.begin(), words.end(),
		[&os, c](const string& s) { cout << s << c; });

	sort(words.begin(), words.end(),
		[](const string& s1, const string& s2) { return s1 > s2;  });

	for_each(words.begin(), words.end(),
		[&os, c](const string& s) { cout << s << c; });

	int num = 2;

	cout <<
		count_if(words.begin(), words.end(),
			[num](const string& s) { return s.length() < num;  })
		<< endl;

}

// ������ Ȱ�뿹 2��: ������ �Լ�
void example3() {
	auto addtwointegers = [](int x) -> function<int(int)> {
		return [=](int y) { return x + y;  };
	};

	auto higherorder = [](const function<int(int)>& f, int z) {
		return f(z) * 2;
	};

	auto answer = higherorder(addtwointegers(7), 8);

	cout << answer << endl;
}