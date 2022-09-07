# Execution begins at address 0
        .pos 0
        irmovq stack, %rsp  # Set up stack pointer
        call main           # Execution main program
        halt
# Sample linked list
        .align 8
    ele1:
        .quad 0x00a
        .quad ele2
    ele2:
        .quad 0x0b0
        .quad ele3
    ele3:
        .quad 0xc00
        .quad 0
    main:
        irmovq ele1,%rdi # 传参数值
        call sum_list     # 调用函数
        ret
sum_list:
        xorq    %rax,%rax     # 设置 sum 初值为 0，long val = 0
# sum = 0 
        andq    %rdi , %rdi   # 判断 ls （就是链表指针，最初为传入值，链表的首地址）是否为 0
        je  end               # ls 为 0 时直接返回
loop:   mrmovq  (%rdi) , %rcx # 循环： 保存 ls->val
        addq    %rcx , %rax   # 给 sum 累加值,就是 val += ls->val
        irmovq  $8 , %rbx     # 保存 8
        addq    %rbx , %rdi   # 链表指针加 8 ，就是 &(ls->next)
        mrmovq (%rdi),  %rdi  # ls=ls->next
        andq    %rdi , %rdi   # 判断 ls 是否为 0
        jne loop              # ls 不为 0 时循环
end:
        ret                   # 返回

# Stack starts here and grows to lower addresses
        .pos 0x200
stack:
# sum_list 反汇编 
; 0000000000000000 <sum_list>:
;    0:   f3 0f 1e fa             endbr64
;    4:   b8 00 00 00 00          mov    $0x0,%eax
;    9:   eb 07                   jmp    12 <sum_list+0x12>
;    b:   48 03 07                add    (%rdi),%rax
;    e:   48 8b 7f 08             mov    0x8(%rdi),%rdi
;   12:   48 85 ff                test   %rdi,%rdi
;   15:   75 f4                   jne    b <sum_list+0xb>
;   17:   c3                      ret
