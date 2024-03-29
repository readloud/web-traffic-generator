.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;
.super Landroid/os/CountDownTimer;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000000"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

.field private final val$mainLayout:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;JJLandroid/widget/LinearLayout;)V
    .locals 13

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-wide/from16 v4, p4

    move-object/from16 v6, p6

    move-object v8, v0

    move-wide v9, v2

    move-wide v11, v4

    invoke-direct {v8, v9, v10, v11, v12}, Landroid/os/CountDownTimer;-><init>(JJ)V

    move-object v8, v0

    move-object v9, v1

    iput-object v9, v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v8, v0

    move-object v9, v6

    iput-object v9, v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;->val$mainLayout:Landroid/widget/LinearLayout;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

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
    .line 43
    move-object v0, p0

    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity;->im01:Landroid/widget/ImageView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 44
    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/MainActivity$100000000;->val$mainLayout:Landroid/widget/LinearLayout;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

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
