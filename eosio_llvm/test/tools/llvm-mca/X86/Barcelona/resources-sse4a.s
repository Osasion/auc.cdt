# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -instruction-tables < %s | FileCheck %s

extrq       %xmm0, %xmm2
extrq       $22, $2, %xmm2

insertq     %xmm0, %xmm2
insertq     $22, $22, %xmm0, %xmm2

movntsd     %xmm0, (%rax)
movntss     %xmm0, (%rax)

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        extrq	%xmm0, %xmm2
# CHECK-NEXT:  1      1     0.50                        extrq	$22, $2, %xmm2
# CHECK-NEXT:  1      1     0.50                        insertq	%xmm0, %xmm2
# CHECK-NEXT:  1      1     0.50                        insertq	$22, $22, %xmm0, %xmm2
# CHECK-NEXT:  1      1     1.00           *            movntsd	%xmm0, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movntss	%xmm0, (%rax)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -     2.00   2.00   2.00   1.00   1.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     extrq	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     extrq	$22, $2, %xmm2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     insertq	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     insertq	$22, $22, %xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -     1.00    -     0.50   0.50   movntsd	%xmm0, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     0.50   0.50   movntss	%xmm0, (%rax)
