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
        irmovq ele1,%rdi # ������ֵ
        call sum_list     # ���ú���
        ret
sum_list:
        xorq    %rax,%rax     # ���� sum ��ֵΪ 0��long val = 0
# sum = 0 
        andq    %rdi , %rdi   # �ж� ls ����������ָ�룬���Ϊ����ֵ��������׵�ַ���Ƿ�Ϊ 0
        je  end               # ls Ϊ 0 ʱֱ�ӷ���
loop:   mrmovq  (%rdi) , %rcx # ѭ���� ���� ls->val
        addq    %rcx , %rax   # �� sum �ۼ�ֵ,���� val += ls->val
        irmovq  $8 , %rbx     # ���� 8
        addq    %rbx , %rdi   # ����ָ��� 8 ������ &(ls->next)
        mrmovq (%rdi),  %rdi  # ls=ls->next
        andq    %rdi , %rdi   # �ж� ls �Ƿ�Ϊ 0
        jne loop              # ls ��Ϊ 0 ʱѭ��
end:
        ret                   # ����

# Stack starts here and grows to lower addresses
        .pos 0x200
stack:
# sum_list ����� 
; 0000000000000000 <sum_list>:
;    0:   f3 0f 1e fa             endbr64
;    4:   b8 00 00 00 00          mov    $0x0,%eax
;    9:   eb 07                   jmp    12 <sum_list+0x12>
;    b:   48 03 07                add    (%rdi),%rax
;    e:   48 8b 7f 08             mov    0x8(%rdi),%rdi
;   12:   48 85 ff                test   %rdi,%rdi
;   15:   75 f4                   jne    b <sum_list+0xb>
;   17:   c3                      ret
