#include<iostream>

template <typename T>
struct Node {
    T* init = nullptr;
    size_t size = 0;
    Node* next = nullptr;
};

template <typename T>
class List {
public:
    List() = default;
    
    List(T* init, size_t size) {
        push_back(init, size);
    }
    
    ~List() {
        clear();
    }
    
    List& operator =(List&& other) {
        clear();
        first = other.first;
        last = other.last;
        other.first = nullptr;
        other.last = nullptr;
    }
    
    void push_back(T* init, size_t size) {
        auto* node = new Node<T>();
        node->init = init;
        node->size = size;
        node->next = nullptr;
        
        if (first == nullptr) { 
            first = node;
            last = node;
        }
        else {
            last->next = node;
            last = node;
        }
    }
    
    template<typename CallableT>
    void foreach(CallableT callable) const {
        for (auto it = first; it != nullptr; ) {
            callable(it->init, it->size);
            it = it->next;
        }
    }
    
    void print(const char* sep) const {
        for (auto it = first; it != nullptr; ) {
            std::cout << it->size;
            it = it->next;
            if (it != nullptr)
                std::cout << ", ";
        }
    }
    
private:
    Node<T>* first = nullptr;
    Node<T>* last = nullptr;

    void clear() {
        for (auto it = first; it != nullptr; ) {
            auto* next = it->next;
            delete it;
            it = next;
        }
    }
};

template <typename T>
class MemoryManager {
public:
    MemoryManager(T* array, size_t size)
    : m_data(array)
    , m_size(size) {
        T prev = 1;
        size_t free = 0;
        for (int i = 0; i < m_size; ++i) {
            auto& curr = m_data[i];
            if (curr == 0) {
                if (prev != 0)
                    free = 1;
                else
                    ++free;
            }
            else if (prev == 0) {
                m_free.push_back(&curr - free, free);
                free = 0;
            }
            prev = curr;
        }
        if (free != 0)
            m_free.push_back(m_data + m_size - free, free);
    }
    
    void print() const {
        std::cout << "Free block lengths: ";
        m_free.print(",");
        std::cout << " | Occupied block contents: ";
        auto* init = m_data;
        m_free.foreach([&] (T* free, size_t size) {
            auto* end = free;
            print(init, end);
            auto* next = end + size;
            if (init != end && next != m_data + m_size)
                std::cout << ", ";
            init = next;
        });
        print(init, m_data + m_size);
        std::cout << std::endl;
    }
    
    MemoryManager<T>& defragment() {
        auto* init = m_data;
        m_free.foreach([&] (T* free, size_t size) {
            auto* end = free;
            defragment(init, end, size);
            init += size;
        });
        if (init != m_data)
            m_free = List<T>(m_data, init - m_data);
        return *this;
    }
    
private:
    T* m_data = nullptr;
    size_t m_size = 0;
    List<T> m_free;
    
    void print(T* init, T* end) const {
        for (auto* curr = init; curr != end; ++curr) {
            std::cout << static_cast<char>(*curr);
        }
    }

    void defragment(T* init, T* end, size_t size) {
        for (auto* curr = end - 1; curr >= init; --curr) {
            *(curr + size) = *curr;
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
        'S', '!',
    }; // occupied block of 2
    MemoryManager<int> mm(array, 21);
    mm.print();
    mm.defragment().print();

    int array2[] = {
        0, 0, 0, // free block of 3
        0, 0, 0, 0, 0, // free block of 5
        0, 0, // free block of 2
    };
    MemoryManager<int> mm2(array2, 10);
    mm2.print();
    mm2.defragment().print();

    int array3[] = {
        'C', 'O', 'N', 'T', 'I', // occupied block of 5
        'G', 'U', 'O', 'U', // occupied block of 4
        'S', '!',
    }; // occupied block of 2
    MemoryManager<int> mm3(array3, 11);
    mm3.print();
    mm3.defragment().print();

    int array4[] = {
        0, 0, 0, // free block of 3
        0, 0, 0, 0, 0, // free block of 5
        0, 0, // free block of 2
        'C', 'O', 'N', 'T', 'I', // occupied block of 5
        'G', 'U', 'O', 'U', // occupied block of 4
        'S', '!',
    }; // occupied block of 2
    MemoryManager<int> mm4(array4, 21);
    mm4.print();
    mm4.defragment().print();

    int array5[] = {
        'C', 'O', 'N', 'T', 'I', // occupied block of 5
        'G', 'U', 'O', 'U', // occupied block of 4
        'S', '!', // occupied block of 2
        0, 0, 0, // free block of 3
        0, 0, 0, 0, 0, // free block of 5
        0, 0, // free block of 2
    };
    MemoryManager<int> mm5(array5, 21);
    mm5.print();
    mm5.defragment().print();

    int array6[] = {
        'C', 'O', 'N', 'T', 'I', // occupied block of 5
        0, 0, 0, // free block of 3
        'G', 'U', 'O', 'U', // occupied block of 4
        0, 0, 0, 0, 0, // free block of 5
        'S', '!', // occupied block of 2
        0, 0, // free block of 2
    };
    MemoryManager<int> mm6(array6, 21);
    mm6.print();
    mm6.defragment().print();

    return 0;
}
