#include<iostream>
#include<list>

template <typename T>
class MemoryManager {
public:
    MemoryManager(T* array, size_t size)
    : m_data(array)
    , m_size(size) {
        T prev = 1;
        for (int i = 0; i < m_size; ++i) {
            auto& curr = m_data[i];
            if (curr == 0) {
                if (prev != 0)
                    m_free.push_back({&curr, 1});
                else
                    m_free.back().second += 1;
            }
            prev = curr;
        }
    }
    
    void print() const {
        std::cout << "Free block lengths: ";
        for (auto it = m_free.cbegin(); it != m_free.cend(); ) {
            std::cout << it->second;
            ++it;
            if (it != m_free.cend())
                std::cout << ", ";
        }
        std::cout << " | Occupied block contents: ";
        auto* init = m_data;
        for (auto it = m_free.cbegin(); it != m_free.cend(); ++it) {
            auto* end = it->first;
            print(init, end);
            auto* next = end + it->second;
            if (init != end && next != m_data + m_size)
                std::cout << ", ";
            init = next;
        }
        print(init, m_data + m_size);
        std::cout << std::endl;
    }
    
    MemoryManager<T>& defragment() {
        return *this;
    }
    
private:
    T* m_data = nullptr;
    size_t m_size = 0;
    std::list<std::pair<T*, size_t>> m_free;
    
    void print(T* init, T* end) const {
        for (auto* curr = init; curr != end; ++curr) {
            std::cout << static_cast<char>(*curr);
        }
    }
};

int main() {
    int array[] = {
        0, 0, 0, // free block of 3
        'C', 'O', 'N', 'T', 'I', // occupied block of 5
        0, 0, 0, 0, 0, // free block of 5
        'G', 'U', 'O', 'U', // occupied block of 4
        0, 0, // free block of 2
        'S', '!'
    }; // occupied block of 2
    MemoryManager<int> mm(array, 21);
    mm.print();
    mm.defragment().print();
    return 0;
}