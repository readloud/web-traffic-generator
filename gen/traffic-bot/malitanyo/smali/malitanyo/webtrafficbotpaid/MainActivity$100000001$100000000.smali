.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;
.super Landroid/os/CountDownTimer;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000000"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;JJ)V
    .locals 12

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-wide/from16 v4, p4

    move-object v7, v0

    move-wide v8, v2

    move-wide v10, v4

    invoke-direct {v7, v8, v9, v10, v11}, Landroid/os/CountDownTimer;-><init>(JJ)V

    move-object v7, v0

    move-object v8, v1

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;)Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onFinish()V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 76
    move-object v0, p0

    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    invoke-static {v2}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;)Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-result-object v2

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->but1:Landroid/widget/Button;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setVisibility(I)V

    .line 77
    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    invoke-static {v2}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;)Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-result-object v2

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->but3:Landroid/widget/Button;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setVisibility(I)V

    .line 78
    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    invoke-static {v2}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;)Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-result-object v2

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->but4:Landroid/widget/Button;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setVisibility(I)V

    .line 79
    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;

    invoke-static {v2}, Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000001;)Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-result-object v2

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->but5:Landroid/widget/Button;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setVisibility(I)V

    return-void
.end method

.method public onTick(J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J)V"
        }
    .end annotation

    return-void
.end method
