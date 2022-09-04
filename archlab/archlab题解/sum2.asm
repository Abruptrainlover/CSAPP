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
        irmovq ele1,%rdi    # 传参数值
        call rsum_list      # 调用函数rsum_list(linklist)
        ret
rsum_list:
        andq %rdi,%rdi      # 判断是否为空
        je return
        pushq %rbx          # 保存现在值
        pushq %r12
        mrmovq (%rdi),%rbx  
        irmovq $0x8,%r12    # 指针指向下一个结点
        addq %r12,%rdi      
        mrmovq (%rdi),%rdi  # 
        call rsum_list
        addq %rbx,%rax
        popq %r12
        popq %rbx
        ret
return: 
        irmovq $0x0,%rax
        ret
# Stack starts here and grows to lower addresses
        .pos 0x200
stack:







# rsum_list反汇编得到的代码

;   18:   f3 0f 1e fa             endbr64
;   1c:   48 85 ff                test   %rdi,%rdi
;   1f:   74 12                   je     33 <rsum_list+0x1b>
;   21:   53                      push   %rbx
;   22:   48 8b 1f                mov    (%rdi),%rbx
;   25:   48 8b 7f 08             mov    0x8(%rdi),%rdi
;   29:   e8 00 00 00 00          call   2e <rsum_list+0x16>
;   2e:   48 01 d8                add    %rbx,%rax
;   31:   5b                      pop    %rbx
;   32:   c3                      ret
;   33:   b8 00 00 00 00          mov    $0x0,%eax
;   38:   c3                      ret